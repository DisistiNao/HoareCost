module Examples.Assign where

import VCGen
import Solver (proveVCs)
import Syntax
import Examples.Utils (num)
import Variables

-- { a == 0 }
pre :: PropCalc (FOL Vars)
pre = PropVar (Eq (Var A) (num 0))

-- { a == 2 }
pos:: PropCalc (FOL Vars)
pos= PropVar (Eq (Var A) (num 2))

-- A := 0; A := A + 2;
cmd :: Command Vars
cmd = CSequence (CAssign A (num 0)) (CAssign A (Plus (Var A) (num 2)))

main :: IO ()
main = do
  putStrLn "--- Teste de Atribuição ---"
  
  let custoAlvo = num 6 
  vcs <- vcg pre cmd pos custoAlvo
  -- mapM_ (putStrLn . show) vcs
  proveVCs vcs