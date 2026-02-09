module Examples.Assign where

import VCGen
import Solver (proveVCs)
import Syntax
import Examples.Utils (num)

-- { a == 0 }
p :: PropCalc (FOL String)
p = PropVar (Eq (Var "A") (num 0))

-- { a == 2 }
q :: PropCalc (FOL String)
q = PropVar (Eq (Var "A") (num 2))

-- A := 0; A := A + 2;
cmd :: Command String
cmd = CSequence (CAssign "A" (num 0)) (CAssign "A" (Plus (Var "A") (num 2)))

main :: IO ()
main = do
  putStrLn "--- Teste de Atribuição ---"
  
  let custoAlvo = num 6 
  vcs <- vcg p cmd q custoAlvo
  -- mapM_ (putStrLn . show) vcs
  proveVCs vcs