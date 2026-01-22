module Division where

import VCGen
import Syntax

-- Pré-condição P
pre :: PropCalc (FOL String)
pre =
  And
    (And (PropVar (Eq (Var "R") (Var "X"))) (PropVar (Eq (Var "Q") Z)))
    (And (PropVar (Gt (Var "Y") Z)) (PropVar (Ge (Var "X") Z)))

-- Pós-condição Q
post :: PropCalc (FOL String)
post =
  And
    (PropVar (Eq (Var "X") (Plus (Var "R") (Mult (Var "Y") (Var "Q")))))
    (PropVar (Lt (Var "R") (Var "Y")))

cond :: PropCalc (FOL String)
cond = PropVar (Le (Var "Y") (Var "R"))

loopBody :: Command String
loopBody =
  CSequence
    (CAssign "R" (Minus (Var "R") (Var "Y")))
    (CAssign "Q" (Plus (Var "Q") (S Z)))

-- r := x; q := 0; while (y <= r) ...
cmd :: Command String
cmd =
  CSequence
    (CAssign "R" (Var "X"))
    (CSequence
      (CAssign "Q" Z)
      (CWhile "divLoop" cond loopBody))

main :: IO ()
main = do
  putStrLn "--- Teste de Divisão (Invariante via Oráculo) ---"
  
  -- Definimos um custo alvo simbólico alto para a prova
  let custoAlvo = Mult (S (S (S Z))) (Var "X") 

  -- Isso vai disparar o Oracle.getLine no terminal!
  vcs <- vcg pre cmd post custoAlvo
  
  putStrLn "\nVerification Conditions geradas para a Divisão:"
  mapM_ (putStrLn . show) vcs