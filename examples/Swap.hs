module Swap where

import Costs
import Imp
import Hoare
import Oracle
import Syntax
import Variables

p :: PropCalc (FOL Vars)
p =
  And
    (And
      (PropVar (Eq (Var A) Z))
      (PropVar (Eq (Var B) Z)))
    (PropVar (Eq (Var C) Z))

q :: PropCalc (FOL Vars)
q =
  And
    (And
      (PropVar (Eq (Var A) (Var B)))
      (PropVar (Eq (Var B) (Var C))))
    (PropVar (Eq (Var C) (Var A)))

cmd :: Command Vars
cmd =
  CSequence
    (CSequence
      (CAssign C (Var A))
      (CAssign A (Var B)))
    (CAssign B (Var C))

main :: IO ()
main = do
  putStrLn "Swap program with cost:"
  body <- costCmd (HoareTriple p cmd q)
  print body
