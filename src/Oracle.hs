module Oracle where

import Syntax

data OracleData = OracleData
    {
        invariant :: PropCalc (FOL a),
        variant :: Arith a,
        numIterations :: Arith a,
        costFunction :: Arith a
    }

getOracle :: String -> IO OracleData
getOracle loopID = do
    cache <- readIORef oracleCache
    case M.lookup loopId cache of
        Just entry -> pure entry
        Nothing -> do
            entry <- askForOracle
            modifyIORef' oracleCache (M.insert loopId entry)
            pure entry

oracleCache :: IORef (M.Map String OracleEntry)
oracleCache = unsafePerformIO (newIORef M.empty)

clearOracleCache :: IO ()
clearOracleCache = writeIORef oracleCache M.empty

{-
askForOracle :: IO OracleData
askForOracle = catch readInputs handleError
    where
        readInputs = do
            putStr "Invariant: "
            hFlush stdout
            invStr <- getLine
            let inv = parsePropCalc invStr

            putStr "Variant: "
            hFlush stdout
            varStr <- getLine
            let var = parseArith varStr

            putStr "Number of Iterations: "
            hFlush stdout
            nStr <- getLine
            let n = parseArith nStr

            putStr "Cost Function of While (example: k -> 1 + k): "
            hFlush stdout
            tStr <- getLine
            let t = parseArith tStr

            pure $ OracleEntry inv var n t
        
        handleError :: SomeException -> IO OracleEntry
        handleError _ = do
            putStrLn "Oracle Error (default values used)"
            pure $ OracleEntry
                (PropVar (Eq Z Z))
                Z
                (S Z)
                (S Z)
-}

-- parsePropCalc :: String -> PropCalc (FOL a)

-- parseArith :: -> String -> Arith a