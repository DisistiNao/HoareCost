module Swap where

import Costs
import Imp
import Hoare
import Oracle
import Syntax
import Variables

p1 :: PropCalc (FOL Vars)
p1 =
  And
    (And
      (PropVar (Eq (Var A) Z))
      (PropVar (Eq (Var B) Z)))
    (PropVar (Eq (Var C) Z))

p2 :: PropCalc (FOL Vars)
p2 =
  And
    (And
      (PropVar (Eq (Var A) Z))
      (PropVar (Eq (Var B) Z)))
    (PropVar (Eq (Var C) (Var A)))

p3 :: PropCalc (FOL Vars)
p3 =
  And
    (And
      (PropVar (Eq (Var A) (Var B)))
      (PropVar (Eq (Var B) Z)))
    (PropVar (Eq (Var C) (Var A)))

h1, h2, h3 :: ESCost Vars
h1 = costAssignment C (Var A) p1
h2 = costAssignment A (Var B) p2
h3 = costAssignment B (Var C) p3

body :: ESCost Vars
body = do
  t1  <- h1
  t2  <- h2
  t12 <- costSequence t1 t2
  t3  <- h3
  costSequence t12 t3

main :: IO ()
main = do
  putStrLn "Swap program with cost:"
  print body
