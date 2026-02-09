module Division where

import VCGen
import Solver (proveVCs)
import Syntax
import Utils (num)

-- { r == x and q == 0 and y > 0 and x >= 0 }
pre :: PropCalc (FOL String)
pre =
  And
    (And (PropVar (Eq (Var "R") (Var "X"))) (PropVar (Eq (Var "Q") Z)))
    (And (PropVar (Gt (Var "Y") Z)) (PropVar (Ge (Var "X") Z)))

-- { x == r + y * q and r < y }
post :: PropCalc (FOL String)
post =
  And
    (PropVar (Eq (Var "X") (Plus (Var "R") (Mult (Var "Y") (Var "Q")))))
    (PropVar (Lt (Var "R") (Var "Y")))

-- y <= r
cond :: PropCalc (FOL String)
cond = PropVar (Le (Var "Y") (Var "R"))

loopBody :: Command String
loopBody =
  CSequence
    (CAssign "R" (Minus (Var "R") (Var "Y"))) -- r = r - y
    (CAssign "Q" (Plus (Var "Q") (num 1)))    -- q = q + 1

cmd :: Command String
cmd =
  CSequence
    (CAssign "R" (Var "X"))
    (CSequence
      (CAssign "Q" Z)
      (CWhile "divLoop" cond loopBody))

main :: IO ()
main = do
  putStrLn ""
  putStrLn "--- Teste de Divisão (Custo Linear: 20x + 10) ---"
  putStrLn ""
  
  let custoAlvo = Plus (Mult (num 20) (Var "X")) (num 10)
  vcs <- vcg pre cmd post custoAlvo
  -- mapM_ (putStrLn . show) vcs
  proveVCs vcs