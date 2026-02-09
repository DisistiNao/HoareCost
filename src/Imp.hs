module Imp where

import Syntax
import qualified Data.Map as M

type Context a = M.Map a Integer

aeval :: (Ord a, Eq a) => Context a -> Arith a -> Either String Integer
aeval ctx (Var v) = 
  case M.lookup v ctx of
    Just val -> Right val
    -- Nothing  -> Left $ "Variável não encontrada no contexto: " ++ show v
    Nothing  -> Left $ "Variável não encontrada no contexto: "
aeval ctx Z              = Right 0
aeval ctx (S a)          = aeval ctx a >>= \a -> Right $ 1 + a
aeval ctx (Plus a1 a2)   = aeval ctx a1 >>= \a1 -> aeval ctx a2 >>= \a2 -> Right $ a1 + a2
aeval ctx (Minus a1 a2)  = aeval ctx a1 >>= \a1 -> aeval ctx a2 >>= \a2 -> Right $ max 0 (a1 - a2)
aeval ctx (Mult a1 a2)   = aeval ctx a1 >>= \a1 -> aeval ctx a2 >>= \a2 -> Right $ a1 * a2

beval :: (Ord a, Eq a) => Context a -> PropCalc (FOL a) -> Either String Bool
beval ctx (PropVar (Eq a1 a2))   = aeval ctx a1 >>= \a1 -> aeval ctx a2 >>= \a2 -> Right $ a1 == a2
beval ctx (PropVar (Lt a1 a2))   = aeval ctx a1 >>= \a1 -> aeval ctx a2 >>= \a2 -> Right $ a1 < a2
beval ctx (PropVar (Gt a1 a2))   = aeval ctx a1 >>= \a1 -> aeval ctx a2 >>= \a2 -> Right $ a1 > a2
beval ctx (PropVar (Le a1 a2))   = aeval ctx a1 >>= \a1 -> aeval ctx a2 >>= \a2 -> Right $ a1 <= a2
beval ctx (PropVar (Ge a1 a2))   = aeval ctx a1 >>= \a1 -> aeval ctx a2 >>= \a2 -> Right $ a1 >= a2
beval ctx (PropVar (ForAll x b)) = 
  let domain = [0..10]
      results = map (\val -> beval (M.insert x val ctx) b) domain
  in sequence results >>= \bools -> Right (all id bools)
beval ctx (PropVar (Exists x b)) = 
  let domain = [0..10]
      results = map (\val -> beval (M.insert x val ctx) b) domain
  in sequence results >>= \bools -> Right (any id bools)
beval ctx (Not b)     = beval ctx b >>= \b -> Right $ not b
beval ctx (And b1 b2) = beval ctx b1 >>= \b1 -> beval ctx b2 >>= \b2 -> Right $ b1 && b2
beval ctx (Or b1 b2)  = beval ctx b1 >>= \b1 -> beval ctx b2 >>= \b2 -> Right $ b1 || b2
beval ctx (Imp b1 b2) = beval ctx b1 >>= \b1 -> beval ctx b2 >>= \b2 -> Right $ not b1 || b2

eval :: (Ord a, Eq a) => Context a -> Command a -> Either String (Context a)
-- eval ctx CSkip             = Right ctx
eval ctx (CAssign c v)     = aeval ctx v >>= \v -> Right $ M.insert c v ctx
eval ctx (CSequence c1 c2) = let ctx' = eval ctx c1 in ctx' >>= (\ctx'' -> eval ctx'' c2)
eval ctx (CIfElse b c1 c2) = beval ctx b >>= \b -> eval ctx $ if b then c1 else c2
eval ctx (CWhile name b c)      = beval ctx b >>= \b' ->
  if b'
  then let ctx' = eval ctx c in ctx' >>= (\ctx'' -> eval ctx'' (CWhile name b c))
  else Right ctx
-- eval ctx (CAssert b1 c b2) = beval ctx b1 >>= \b1 ->
--   if b1
--   then eval ctx c >>=
--        (\ctx' -> beval ctx' b2 >>= \b2 ->
--                   if b2
--                   then Right ctx'
--                   else Left "Assert: Post-condition does not match!")
--   else Left "Assert: Pre-condition does not match!"