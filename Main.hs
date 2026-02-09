module Main where

import Imp
-- import Hoare
import Lexer.Lexer
import Parser.Arith
import Parser.PropCalc
import Oracle
import Syntax
import Variables

main :: IO ()
main = putStrLn "Hello, Haskell!"

i :: PropCalc (FOL Vars)
i =
  And
    (PropVar (Eq (Var X)
      (Plus (Var R) (Mult (Var Y) (Var Q)))))
    (PropVar (Ge (Var R) Z))