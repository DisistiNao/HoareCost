module Costs where

import Syntax
import Hoare
import Imp
import Oracle

data CostHoareTriple a =
    CostHoareTriple (HoareTriple a) (Arith String)
    deriving (Show)

type ESCost a = Either String (CostHoareTriple a)

costSkip :: PropCalc (FOL a) -> ESCost a
costSkip q = Right $ CostHoareTriple (HoareTriple q CSkip q) Z

costAssignment :: Eq a => a -> Arith a -> PropCalc (FOL a) -> ESCost a
costAssignment v e q = do
    ht <- hoareAssignment v e q
    pure $ CostHoareTriple
        ht
        (Plus (costAExpr e) (S Z))

costConsequence :: Eq a => Proof (PropCalc (FOL a)) -> CostHoareTriple a -> Proof (PropCalc (FOL a)) -> ESCost a
costConsequence (Proof (Imp p1 p2)) (CostHoareTriple (HoareTriple p2' c q2) costValue) (Proof (Imp q2' q1))
  | p2 == p2' && q2 == q2' = Right $ CostHoareTriple (HoareTriple p1 c q1) costValue
costConsequence _ _ _ = Left "costConsequence: Cannot construct proof"

costSequence :: Eq a => CostHoareTriple a -> CostHoareTriple a -> ESCost a
costSequence (CostHoareTriple (HoareTriple p c1 q1) cost1)
             (CostHoareTriple (HoareTriple q2 c2 r) cost2)
  | q1 == q2 = Right $ CostHoareTriple (HoareTriple p (CSequence c1 c2) r) (Plus cost1 cost2)
costSequence _ _ = Left "costSequence: Cannot construct proof"

costConditional :: Eq a => CostHoareTriple a -> CostHoareTriple a -> ESCost a
costConditional (CostHoareTriple (HoareTriple (And b1 p1) c1 q1) cost1)
                (CostHoareTriple (HoareTriple (And (Not b2) p2) c2 q2) cost2)
  | b1 == b2 && p1 == p2 && q1 == q2 =
    --   let chosen = if cost1 >= cost2 then cost1 else cost2 -- Need to create a function that determines which Arith String is greater than
      let chosen = cost1 -- For now, we will always use the first cost
      in Right $ CostHoareTriple (HoareTriple p1 (CIfElse b1 c1 c2) q1) (Plus (costBExpr b1) chosen)
costConditional _ _ = Left "costConditional: Cannot construct proof"

costWhile :: Eq a => String -> CostHoareTriple a -> IO (ESCost a)
costWhile loopId (CostHoareTriple (HoareTriple (And b p1) c p2) _) | p1 == p2 = do
  OracleData inv variant n costFun <- getOracle loopId

  let condCost = costBExpr b
  let bodyTriple = CostHoareTriple (HoareTriple p1 c p1) Z
  let hSkip = CostHoareTriple (HoareTriple p1 CSkip p1) Z

  case costSequence bodyTriple hSkip of
    Left err -> pure (Left err)
    Right (CostHoareTriple _ bodyCost) -> do
      let aux = Plus (S Z) (Plus condCost bodyCost)
      let totalCost = Mult aux n
      pure $ Right $
        CostHoareTriple
          (HoareTriple p1 (CWhile b c) (And (Not b) p1))
          totalCost
costWhile _ _ = pure $ Left "costWhile: Cannot construct proof"

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
-- costBExpr (PropVar (Eq a1 a2)) = Plus (Plus (costAExpr a1) (costAExpr a2)) (S Z)
costBExpr (PropVar _) = S Z
costBExpr (Not a) = Plus (costBExpr a) (S Z)
costBExpr (And a1 a2) = Plus (Plus (costBExpr a1) (costBExpr a2)) (S Z)
costBExpr (Or  a1 a2) = Plus (Plus (costBExpr a1) (costBExpr a2)) (S Z)
costBExpr (Imp a1 a2) = Plus (Plus (costBExpr a1) (costBExpr a2)) (S Z)