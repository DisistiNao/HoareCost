module Main where

import qualified Parser.Parser as Parser

import System.Environment (getArgs)
import Control.Exception (catch, IOException)
import System.IO (readFile)

main :: IO ()
main = do
    args <- getArgs
    case args of
        (fileName:_) -> do
            putStrLn ("Name file: " ++ fileName)
            catch
                (do
                    file <- readFile fileName
                    Parser.run file
                )
                handleError
        [] ->
            putStrLn "No file name provided."

handleError :: IOException -> IO ()
handleError _ =
    putStrLn "Error: Could not open the file."
