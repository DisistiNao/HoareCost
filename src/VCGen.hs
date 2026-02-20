module VCGen where

import Syntax
import Oracle
import Variables

wpc :: Command Vars -> PropCalc (FOL Vars) -> IO (PropCalc (FOL Vars), Arith Vars)
wpc CSkip pos = 
  pure (pos, S Z)

wpc (CAssign val exp) pos = pure (subst pos val exp, Plus (costAExpr exp) (S Z))

wpc (CSequence c1 c2) pos = do
  (wp2, t2) <- wpc c2 pos
  (wp1, t1) <- wpc c1 wp2
  pure (wp1, Plus t1 t2)

wpc (CIfElse cond c1 c2) pos = do
  (wp1, t1) <- wpc c1 pos
  (wp2, t2) <- wpc c2 pos
  let wp = And (Imp cond wp1) (Imp (Not cond) wp2)
  pure (wp, Plus (Max t1 t2) (costBExpr cond))

wpc (CWhile loopId cond body) pos = do
  OracleData inv variant n _ <- getOracle loopId
  
  (_, bodyCost) <- wpc body inv 
  let totalCondCost = Mult (Plus (S Z) (costBExpr cond)) (Plus n (S Z))
  let totalBodyCost = Mult bodyCost n
  
  let cost = Plus totalCondCost totalBodyCost
  
  let wp = And inv (PropVar (Ge variant Z))
  
  pure (wp, cost)

vc :: Command Vars -> PropCalc (FOL Vars) -> IO [PropCalc (FOL Vars)]
vc CSkip _ = pure []
vc (CAssign _ _) _ = pure []

vc (CSequence c1 c2) pos = do
  (wp2, _) <- wpc c2 pos
  vcs1 <- vc c1 wp2
  vcs2 <- vc c2 pos
  pure (vcs1 ++ vcs2)

vc (CIfElse cond c1 c2) pos = do
  vcs1 <- vc c1 pos
  vcs2 <- vc c2 pos
  pure (vcs1 ++ vcs2)

vc (CWhile loopId cond c) pos = do
  OracleData inv variant n costFun <- getOracle loopId
  
  let varK = Var K
  let postBody = And inv (PropVar (Gt variant varK))
  (wpS, tS) <- wpc c postBody
  vcsBody <- vc c inv
  
  let 
    vc1 = PropVar (ForAll K (Imp (And (And inv cond) (PropVar (Eq variant (Var K)))) wpS))
    vc2 = Imp (And inv (Not cond)) pos
    vc3 = Imp (And inv cond) (PropVar (Le variant n))
    vc4 = PropVar (ForAll K (Imp (And inv cond) (PropVar (Ge costFun tS))))
    
  pure ([vc1, vc2, vc3, vc4] ++ vcsBody)

vcg :: PropCalc (FOL Vars) -> Command Vars -> PropCalc (FOL Vars) -> Arith Vars -> IO [PropCalc (FOL Vars)]
vcg pre body pos t = do
  (wp, ts) <- wpc body pos
  vcs <- vc body pos
  let 
    c1 = Imp pre wp
    c2 = Imp pre (PropVar (Ge t ts)) 
  pure (c1 : c2 : vcs)

costAExpr :: Arith a -> Arith Vars
costAExpr (Var _) = S Z
costAExpr Z = S Z
costAExpr (S a) = costAExpr a
costAExpr (Plus a1 a2)  = Plus (Plus (costAExpr a1) (costAExpr a2)) (S Z)
costAExpr (Minus a1 a2) = Plus (Plus (costAExpr a1) (costAExpr a2)) (S Z)
costAExpr (Mult a1 a2)  = Plus (Plus (costAExpr a1) (costAExpr a2)) (S Z)
costAExpr (Max a1 a2)   = Z

costBExpr :: PropCalc (FOL a) -> Arith Vars
costBExpr (PropVar (Lt a1 a2)) = Plus (Plus (costAExpr a1) (costAExpr a2)) (S Z)
costBExpr (PropVar (Gt a1 a2)) = Plus (Plus (costAExpr a1) (costAExpr a2)) (S Z)
costBExpr (PropVar (Le a1 a2)) = Plus (Plus (costAExpr a1) (costAExpr a2)) (S Z)
costBExpr (PropVar (Ge a1 a2)) = Plus (Plus (costAExpr a1) (costAExpr a2)) (S Z)
costBExpr (PropVar (Eq a1 a2)) = Plus (Plus (costAExpr a1) (costAExpr a2)) (S Z)
costBExpr (PropVar _) = S Z
costBExpr (Not a) = Plus (costBExpr a) (S Z)
costBExpr (And a1 a2) = Plus (Plus (costBExpr a1) (costBExpr a2)) (S Z)
costBExpr (Or  a1 a2) = Plus (Plus (costBExpr a1) (costBExpr a2)) (S Z)
costBExpr (Imp a1 a2) = Plus (Plus (costBExpr a1) (costBExpr a2)) (S Z)