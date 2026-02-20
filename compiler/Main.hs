module Main where

import Control.Exception (catch, IOException)
import System.Environment (getArgs)
import System.IO (readFile)

import Parser.Parser (hcParser, HCLang(..))
import Solver (proveVCs)
import VCGen

main :: IO ()
main = do
    args <- getArgs
    case args of
        (fileName:_) -> do
            putStrLn ("Name file: " ++ fileName)
            catch
                (do
                    file <- readFile fileName
                    run file
                )
                handleError
        [] ->
            putStrLn "No file name provided."

handleError :: IOException -> IO ()
handleError _ =
    putStrLn "Error: Could not open the file."

run :: String -> IO ()
run input = do
    putStrLn "Generating VCs for the program..."

    case hcParser input of
        Left err ->
            putStrLn ("Parse error: " ++ err)

        Right (HCLang pre cmd post custoAlvo) -> do
            vcs <- vcg pre cmd post custoAlvo
            proveVCs vcs