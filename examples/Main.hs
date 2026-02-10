module Main where

import qualified Examples.Assign as Assign 
import qualified Examples.Division as Division
import qualified Examples.Swap as Swap

import qualified Compiler.Parser.Parser as Parser

main :: IO ()
main = do
    putStrLn "Run examples"
    -- Swap.main
    -- Assign.main
    -- Division.main
    Parser.run "{0 == 0} X = 0 {X == 0 | 2}"
