module Swap where

import VCGen
import Solver (proveVCs)
import Syntax
import Utils (num)

-- { a == 1 and b == 2 and c == 0 }
p :: PropCalc (FOL String)
p =
  And
    (And
      (PropVar (Eq (Var "A") (num 1)))
      (PropVar (Eq (Var "B") (num 2))))
    (PropVar (Eq (Var "C") (num 0)))

-- { a == 2 and b == 1 and c == 0 }
q :: PropCalc (FOL String)
q =
  And
    (PropVar (Eq (Var "A") (num 2)))
    (PropVar (Eq (Var "B") (num 1)))

-- c = a; a = b; b = c
cmd :: Command String
cmd =
  CSequence
    (CSequence
      (CAssign "C" (Var "A"))
      (CAssign "A" (Var "B")))
    (CAssign "B" (Var "C"))

main :: IO ()
main = do
  putStrLn "Gerando VCs para o programa Swap..."
  
  let custoAlvo = num 9 
  vcs <- vcg p cmd q custoAlvo
  -- mapM_ (putStrLn . show) vcs
  proveVCs vcs