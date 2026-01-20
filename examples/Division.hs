module Division where

import Costs
import Imp
import Hoare
import Oracle hiding (invariant)
import Syntax
import Variables

--------------------------------------------------------------------------------
-- Preconditions
-- { r == x ∧ q == 0 ∧ y > 0 ∧ x ≥ 0 }
--------------------------------------------------------------------------------

pre :: PropCalc (FOL Vars)
pre =
  And
    (And
      (PropVar (Eq (Var R) (Var X)))
      (PropVar (Eq (Var Q) Z)))
    (And
      (PropVar (Gt (Var Y) Z))
      (PropVar (Ge (Var X) Z)))

--------------------------------------------------------------------------------
-- Postconditions
-- { x == r + y*q ∧ r < y }
--------------------------------------------------------------------------------

post :: PropCalc (FOL Vars)
post =
  And
    (PropVar
      (Eq (Var X)
        (Plus (Var R) (Mult (Var Y) (Var Q)))))
    (PropVar (Lt (Var R) (Var Y)))

--------------------------------------------------------------------------------
-- Loop condition: while (y ≤ r)
--------------------------------------------------------------------------------

cond :: PropCalc (FOL Vars)
cond =
  PropVar (Le (Var Y) (Var R))

--------------------------------------------------------------------------------
-- Loop invariant
-- x == r + y*q ∧ r ≥ 0 ∧ y > 0
--------------------------------------------------------------------------------

invariant :: PropCalc (FOL Vars)
invariant =
  And
    (And
      (PropVar
        (Eq (Var X)
          (Plus (Var R) (Mult (Var Y) (Var Q)))))
      (PropVar (Ge (Var R) Z)))
    (PropVar (Gt (Var Y) Z))

--------------------------------------------------------------------------------
-- Loop body
-- r := r - y;
-- q := q + 1;
--------------------------------------------------------------------------------

loopBody :: Command Vars
loopBody =
  CSequence
    (CAssign R (Minus (Var R) (Var Y)))
    (CAssign Q (Plus (Var Q) (S Z)))

--------------------------------------------------------------------------------
-- Full program
-- r := x;
-- q := 0;
-- while (y ≤ r) do
--   r := r - y;
--   q := q + 1;
--------------------------------------------------------------------------------

cmd :: Command Vars
cmd =
  CSequence
    (CAssign R (Var X))
    (CSequence
      (CAssign Q Z)
      (CWhile "divLoop" cond loopBody))

--------------------------------------------------------------------------------
-- Main
--------------------------------------------------------------------------------

main :: IO ()
main = do
  putStrLn "Division program with cost:"
  result <- costCmd (HoareTriple pre cmd post)
  print result
