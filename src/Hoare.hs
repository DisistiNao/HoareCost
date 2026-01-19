module Hoare where

import Syntax
import Imp

data HoareTriple a =
  HoareTriple (PropCalc (FOL a)) (Command a) (PropCalc (FOL a))
  deriving (Show)

type ESHT a = Either String (HoareTriple a)

-- | Hoare skip rule
hoareSkip :: PropCalc (FOL a) -> ESHT a
hoareSkip q = Right $ HoareTriple q CSkip q

-- | Hoare assignment rule
hoareAssignment :: Eq a => a -> Arith a -> PropCalc (FOL a) -> ESHT a
hoareAssignment v e q =
  Right $ HoareTriple
  q
  (CAssign v e)
  (substPost v e q)

substPost :: Eq a => a -> Arith a -> PropCalc (FOL a) -> PropCalc (FOL a)
substPost v e = go
  where
    go (PropVar (Eq (Var x) rhs))
      | x == v    = PropVar (Eq (Var v) e)
      | otherwise = PropVar (Eq (Var x) rhs)

    go (PropVar (Eq lhs rhs)) =
      PropVar (Eq lhs rhs)

    go (And p q) = And (go p) (go q)
    go (Or  p q) = Or  (go p) (go q)
    go (Not p)   = Not (go p)
    go (Imp p q) = Imp (go p) (go q)

-- | Hoare consequence rule
hoareConsequence :: Eq a => Proof (PropCalc (FOL a)) -> HoareTriple a -> Proof (PropCalc (FOL a)) -> ESHT a
hoareConsequence (Proof (Imp p1 p2)) (HoareTriple p2' c q2) (Proof (Imp q2' q1))
  | p2 == p2' && q2 == q2' = Right $ HoareTriple p1 c q1
hoareConsequence _ _ _ = Left "hoareConsequence: Cannot construct proof"

-- | Hoare sequence rule
hoareSequence :: Eq a => HoareTriple a -> HoareTriple a -> ESHT a
hoareSequence (HoareTriple p c1 q1) (HoareTriple q2 c2 r)
  | q1 == q2  = Right $ HoareTriple p (CSequence c1 c2) r
hoareSequence _ _ = Left "hoareSequence: Cannot construct proof"

-- | Hoare conditional rule
hoareConditional :: Eq a => HoareTriple a -> HoareTriple a -> ESHT a
hoareConditional (HoareTriple (And b1 p1) c1 q1) (HoareTriple (And (Not b2) p2) c2 q2)
  | b1 == b2 &&
    p1 == p2 &&
    q1 == q2  = Right $ HoareTriple p1 (CIfElse b1 c1 c2) q1
hoareConditional _ _ = Left "hoareConditional: Cannot construct proof"

-- | Hoare while rule
hoareWhile :: Eq a => HoareTriple a -> ESHT a
hoareWhile (HoareTriple (And b p1) c p2)
  | p1 == p2  = Right $ HoareTriple p1 (CWhile b c) (And (Not b) p1)
hoareWhile _ = Left "hoareWhile: Cannot construct proof"