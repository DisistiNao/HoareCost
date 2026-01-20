module Assign where

import Costs
import Imp
import Hoare
import Oracle
import Syntax
import Variables

p :: PropCalc (FOL Vars)
p = (PropVar (Eq (Var A) Z))

q :: PropCalc (FOL Vars)
q = (PropVar (Eq (Var A) (S (S Z))))

two :: Arith Vars
two = S (S Z)

cmd1 :: Command Vars
cmd1 = CAssign A Z

cmd2 :: Command Vars
cmd2 = CSequence cmd1 (CAssign A (Plus (Var A) two))


main :: IO ()
main = do
  putStrLn "Assign program with cost:"
  body1 <- costCmd (HoareTriple p cmd1 q)
  print body1
  body2 <- costCmd (HoareTriple p cmd2 q)
  print body2