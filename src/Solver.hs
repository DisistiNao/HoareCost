module Solver where

import Data.SBV
import qualified Data.Map as M
import Data.List (nub)
import Syntax

type Env = M.Map String SInteger

getFreeVars :: PropCalc (FOL String) -> [String]
getFreeVars p = nub (goProp p)
  where
    goArith (Var x) | x /= "k" = [x]
                    | otherwise = []
    goArith Z = []
    goArith (S a) = goArith a
    goArith (Plus a b) = goArith a ++ goArith b
    goArith (Minus a b) = goArith a ++ goArith b
    goArith (Mult a b) = goArith a ++ goArith b

    goFOL (Eq a b) = goArith a ++ goArith b
    goFOL (Lt a b) = goArith a ++ goArith b
    goFOL (Gt a b) = goArith a ++ goArith b
    goFOL (Le a b) = goArith a ++ goArith b
    goFOL (Ge a b) = goArith a ++ goArith b
    goFOL (ForAll _ body) = goProp body
    goFOL (Exists _ body) = goProp body

    goProp (PropVar f) = goFOL f
    goProp (Not x) = goProp x
    goProp (And x y) = goProp x ++ goProp y
    goProp (Or x y) = goProp x ++ goProp y
    goProp (Imp x y) = goProp x ++ goProp y

transArith :: Arith String -> SInteger -> Env -> Symbolic SInteger
transArith (Var name) k env
  | name == "k" = return k
  | otherwise   = case M.lookup name env of
                    Just v  -> return v
                    Nothing -> error $ "Variável não encontrada no Env: " ++ name
transArith Z _ _              = return 0
transArith (S a) k env        = do { v <- transArith a k env; return (v + 1) }
transArith (Plus a b) k env   = do { v1 <- transArith a k env; v2 <- transArith b k env; return (v1 + v2) }
transArith (Minus a b) k env  = do { v1 <- transArith a k env; v2 <- transArith b k env; return (v1 - v2) }
transArith (Mult a b) k env   = do { v1 <- transArith a k env; v2 <- transArith b k env; return (v1 * v2) }

transFormula :: PropCalc (FOL String) -> Env -> Symbolic SBool
transFormula f env = go f 0
  where
    go :: PropCalc (FOL String) -> SInteger -> Symbolic SBool
    
    go (PropVar (Eq a1 a2)) k = do
        v1 <- transArith a1 k env
        v2 <- transArith a2 k env
        return (v1 .== v2)
    go (PropVar (Lt a1 a2)) k = do { v1 <- transArith a1 k env; v2 <- transArith a2 k env; return (v1 .< v2) }
    go (PropVar (Gt a1 a2)) k = do { v1 <- transArith a1 k env; v2 <- transArith a2 k env; return (v1 .> v2) }
    go (PropVar (Le a1 a2)) k = do { v1 <- transArith a1 k env; v2 <- transArith a2 k env; return (v1 .<= v2) }
    go (PropVar (Ge a1 a2)) k = do { v1 <- transArith a1 k env; v2 <- transArith a2 k env; return (v1 .>= v2) }

    go (PropVar (ForAll x p)) k = do
        symX <- forall x
        if x == "k" then go p symX else go p k

    go (PropVar (Exists x p)) k = do
        symX <- exists x
        if x == "k" then go p symX else go p k

    go (Not p) k = do { v <- go p k; return (sNot v) }
    go (And p q) k = do { v1 <- go p k; v2 <- go q k; return (v1 .&& v2) }
    go (Or p q) k  = do { v1 <- go p k; v2 <- go q k; return (v1 .|| v2) }
    go (Imp p q) k = do { v1 <- go p k; v2 <- go q k; return (v1 .=> v2) }

proveVCs :: [PropCalc (FOL String)] -> IO ()
proveVCs vcs = do
    putStrLn "\n=== Iniciando Verificação Formal com Z3 ==="
    mapM_ proveOne (zip [1..] vcs)
  where
    proveOne (i, vc) = do
        putStr $ "Provando VC #" ++ show i ++ ": "
        
        let varNames = getFreeVars vc
        
        res <- prove $ do
            symVars <- mapM sInteger varNames            
            mapM_ (\v -> constrain (v .>= 0)) symVars
            let env = M.fromList (zip varNames symVars)
            transFormula vc env
            
        print res