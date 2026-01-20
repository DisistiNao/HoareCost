module Division where

import Costs
import Imp
import Hoare
import Oracle hiding (invariant)
import Syntax
import Variables

-- { r == x ∧ q == 0 ∧ y > 0 ∧ x ≥ 0 }
pre :: PropCalc (FOL Vars)
pre =
  And
    (And
      (PropVar (Eq (Var R) (Var X)))
      (PropVar (Eq (Var Q) Z)))
    (And
      (PropVar (Gt (Var Y) Z))
      (PropVar (Ge (Var X) Z)))

-- { x == r + y*q ∧ r < y }
post :: PropCalc (FOL Vars)
post =
  And
    (PropVar (Eq (Var X)
      (Plus (Var R) (Mult (Var Y) (Var Q)))))
    (PropVar (Lt (Var R) (Var Y)))

-- while y ≤ r
cond :: PropCalc (FOL Vars)
cond =
  PropVar (Le (Var Y) (Var R))

-- Invariant: x == r + y*q ∧ r ≥ 0
invariant :: PropCalc (FOL Vars)
invariant =
  And
    (PropVar (Eq (Var X)
      (Plus (Var R) (Mult (Var Y) (Var Q)))))
    (PropVar (Ge (Var R) Z))

-- r = r - y; q = q + 1
body :: ESCost Vars
body = do
  t1 <- costAssignment R (Minus (Var R) (Var Y)) invariant
  t2 <- costAssignment Q (Plus (Var Q) (S Z)) invariant
  costSequence t1 t2

-- while loop with oracle-based cost
-- whileBody :: IO (ESCost Vars)
-- whileBody =
--   costWhile "divLoop" $
--     CostHoareTriple
--       (HoareTriple (And cond invariant)
--                    (CWhile cond CSkip)
--                    invariant)
--       Z

whileBody :: IO (ESCost Vars)
whileBody =
  costWhile "divLoop" $
    CostHoareTriple
      (HoareTriple (And cond invariant)
                   (CSequence
                      (CAssign R (Minus (Var R) (Var Y)))
                      (CAssign Q (Plus (Var Q) (S Z))))
                   invariant)
      Z


main :: IO ()
main = do
--   putStrLn "Division program with cost:"
  result <- whileBody
  print result
