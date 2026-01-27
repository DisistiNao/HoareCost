module VCGen where

import Syntax
import Oracle

wpc :: Command String -> PropCalc (FOL String) -> IO (PropCalc (FOL String), Arith String)
wpc CSkip q = 
  pure (q, S Z)

wpc (CAssign v e) q = pure (subst q v e, Plus (costAExpr e) (S Z))

wpc (CSequence c1 c2) q = do
  (wp2, t2) <- wpc c2 q
  (wp1, t1) <- wpc c1 wp2
  pure (wp1, Plus t1 t2)

wpc (CIfElse b c1 c2) q = do
  (wp1, t1) <- wpc c1 q
  (wp2, t2) <- wpc c2 q
  let wp = And (Imp b wp1) (Imp (Not b) wp2)
  pure (wp, Plus (Plus t1 t2) (costBExpr b))

wpc (CWhile loopId b c) q = do
  OracleData inv variant n costFun <- getOracle loopId
  
  (_, bodyCost) <- wpc c inv 
  let wp = And inv (PropVar (Ge variant Z))
  let totalCondCost = Mult (Plus (S Z) (costBExpr b)) (Plus n (S Z))
  let totalBodyCost = Mult bodyCost n
  
  let cost = Plus totalCondCost totalBodyCost
  
  pure (wp, cost)

vc :: Command String -> PropCalc (FOL String) -> IO [PropCalc (FOL String)]
vc CSkip _ = pure []
vc (CAssign _ _) _ = pure []

vc (CSequence c1 c2) q = do
  (wp2, _) <- wpc c2 q
  vcs1 <- vc c1 wp2
  vcs2 <- vc c2 q
  pure (vcs1 ++ vcs2)

vc (CIfElse b c1 c2) q = do
  vcs1 <- vc c1 q
  vcs2 <- vc c2 q
  pure (vcs1 ++ vcs2)

vc (CWhile loopId b c) q = do
  OracleData inv variant n costFun <- getOracle loopId
  
  let k = Var "k" 
  let postBody = And inv (PropVar (Gt variant k))
  (wpS, tS) <- wpc c postBody
  vcsBody <- vc c inv
  
  let 
    vc1 = PropVar (ForAll "k" (Imp (And (And inv b) (PropVar (Eq variant k))) wpS))
    vc2 = Imp (And inv (Not b)) q
    vc3 = Imp (And inv b) (PropVar (Le variant n))
    vc4 = PropVar (ForAll "k" (Imp (And inv b) (PropVar (Ge costFun tS))))
    
  pure ([vc1, vc2, vc3, vc4] ++ vcsBody)

vcg :: PropCalc (FOL String) -> Command String -> PropCalc (FOL String) -> Arith String -> IO [PropCalc (FOL String)]
vcg p s q t = do
  (wp, ts) <- wpc s q
  vcs <- vc s q
  let 
    c1 = Imp p wp
    c2 = Imp p (PropVar (Ge t ts)) 
  pure (c1 : c2 : vcs)

costAExpr :: Arith a -> Arith String
costAExpr (Var _) = S Z
costAExpr Z = S Z
costAExpr (S a) = costAExpr a
costAExpr (Plus a1 a2)  = Plus (Plus (costAExpr a1) (costAExpr a2)) (S Z)
costAExpr (Minus a1 a2) = Plus (Plus (costAExpr a1) (costAExpr a2)) (S Z)
costAExpr (Mult a1 a2)  = Plus (Plus (costAExpr a1) (costAExpr a2)) (S Z)

costBExpr :: PropCalc (FOL a) -> Arith String
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