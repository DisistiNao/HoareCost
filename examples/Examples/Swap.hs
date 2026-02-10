module Examples.Swap where

import VCGen
import Solver (proveVCs)
import Syntax
import Examples.Utils (num)
import Variables

-- { a == 1 and b == 2 and c == 0 }
pre :: PropCalc (FOL Vars)
pre =
  And
    (And
      (PropVar (Eq (Var A) (num 1)))
      (PropVar (Eq (Var B) (num 2))))
    (PropVar (Eq (Var C) (num 0)))

-- { a == 2 and b == 1 and c == 0 }
pos :: PropCalc (FOL Vars)
pos =
  And
    (PropVar (Eq (Var A) (num 2)))
    (PropVar (Eq (Var B) (num 1)))

-- c = a; a = b; b = c
cmd :: Command Vars
cmd =
  CSequence
    (CSequence
      (CAssign C (Var A))
      (CAssign A (Var B)))
    (CAssign B (Var C))

main :: IO ()
main = do
  putStrLn "Gerando VCs para o programa Swap..."
  
  let custoAlvo = num 9 
  vcs <- vcg pre cmd pos custoAlvo
  -- mapM_ (putStrLn . show) vcs
  proveVCs vcs