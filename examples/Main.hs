module Main where

import qualified Assign
import qualified Swap

main :: IO ()
main = do
    putStrLn "Run examples"
    Swap.main
    Assign.main
 