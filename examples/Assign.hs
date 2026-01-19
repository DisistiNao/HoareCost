module Assign where

import Costs
import Imp
import Hoare
import Oracle
import Syntax
import Variables

p :: PropCalc (FOL Vars)
p = (PropVar (Eq (Var A) Z))

h1, h2 :: ESCost Vars
h1 = costAssignment A Z p
h2 = costAssignment A (Plus (Var A) two) p

two :: Arith Vars
two = S (S Z)

body1 :: ESCost Vars
body1 = h1

body2 :: ESCost Vars
body2 = do
    t1 <- h1
    t2 <- h2
    costSequence t1 t2

main :: IO ()
main = do
  putStrLn "Assign program with cost:"
  print body1
  print body2