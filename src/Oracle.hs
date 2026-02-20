module Oracle where

import Control.Exception (catch, SomeException)
import Data.IORef
import Data.List
import System.IO (hFlush, stdout)
import System.IO.Unsafe (unsafePerformIO)

import qualified Data.Map as M

import Parser.Parser (arithParser, propCalcParser)
import Syntax
import Variables

data OracleData = OracleData
    {
        invariant :: PropCalc (FOL Vars),
        variant :: Arith Vars,
        numIterations :: Arith Vars,
        costFunction :: Arith Vars
    }
    deriving (Show)

getOracle :: String -> IO OracleData
getOracle loopId = do
    cache <- readIORef oracleCache
    case M.lookup loopId cache of
        Just entry -> pure entry
        Nothing -> do
            entry <- askForOracle
            modifyIORef' oracleCache (M.insert loopId entry)
            pure entry

{-# NOINLINE oracleCache #-}
oracleCache :: IORef (M.Map String OracleData)
oracleCache = unsafePerformIO (newIORef M.empty)

askForOracle :: IO OracleData
askForOracle = catch readInputs handleError
    where
        readInputs = do
            putStr "Invariant: "
            hFlush stdout
            invStr <- getLine
            inv <- parseOrFail (propCalcParser invStr)

            putStr "Variant: "
            hFlush stdout
            varStr <- getLine
            var <- parseOrFail (arithParser varStr)

            putStr "Number of Iterations: "
            hFlush stdout
            nStr <- getLine
            num <- parseOrFail (arithParser nStr)

            putStr "Cost Function of While (example: k -> 1 + k): "
            hFlush stdout
            tStr <- getLine
            cost <- parseOrFail (arithParser tStr)

            pure $ OracleData inv var num cost
        
        handleError :: SomeException -> IO OracleData
        handleError _ = do
            putStrLn "Oracle Error (default values used)"
            pure $ OracleData
                (PropVar (Eq Z Z))
                Z
                (S Z)
                (S Z)

parseOrFail :: Either String a -> IO a
parseOrFail (Left err)  = ioError (userError err)
parseOrFail (Right val) = pure val