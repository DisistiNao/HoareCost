module Main where

import qualified Examples.Assign as Assign 
import qualified Examples.Division as Division
import qualified Examples.Swap as Swap

main :: IO ()
main = do
    putStrLn "Run examples"
    -- Swap.main
    -- Assign.main
    Division.main
