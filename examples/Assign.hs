module Assign where

import VCGen
import Syntax

-- P: A == 0
p :: PropCalc (FOL String)
p = PropVar (Eq (Var "A") Z)

-- Q: A == 2
q :: PropCalc (FOL String)
q = PropVar (Eq (Var "A") (S (S Z)))

two :: Arith String
two = S (S Z)

cmd1 :: Command String
cmd1 = CAssign "A" Z

-- cmd2: A := 0; A := A + 2;
cmd2 :: Command String
cmd2 = CSequence cmd1 (CAssign "A" (Plus (Var "A") two))

main :: IO ()
main = do
  putStrLn "--- Teste de Atribuição ---"
  
  -- Custo esperado para cmd2: 
  -- CAssign A Z (cost 2) + CAssign A (A+2) (cost 4) = 6
  let custoAlvo = S (S (S (S (S (S Z))))) 

  vcs <- vcg p cmd2 q custoAlvo
  
  putStrLn "Verification Conditions geradas:"
  mapM_ (putStrLn . show) vcs