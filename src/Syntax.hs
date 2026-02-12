module Syntax where

import Data.List ((\\), nub)

data Arith a =
  Var a
  | Z
  | S (Arith a)
  | Plus (Arith a) (Arith a)
  | Minus (Arith a) (Arith a)
  | Mult (Arith a) (Arith a)
  | Max (Arith a) (Arith a)
  deriving (Eq, Show)

data PropCalc a =
  PropVar a
  | Not (PropCalc a)
  | And (PropCalc a) (PropCalc a)
  | Or (PropCalc a) (PropCalc a)
  | Imp (PropCalc a) (PropCalc a)
  deriving (Eq, Show)

newtype Proof a = Proof a deriving (Eq, Show)

type ESP a = Either String (Proof (PropCalc a))

data FOL a =
  Eq (Arith a) (Arith a)
  | Lt (Arith a) (Arith a)
  | Gt (Arith a) (Arith a)
  | Le (Arith a) (Arith a)
  | Ge (Arith a) (Arith a)
  | ForAll a (PropCalc (FOL a))
  | Exists a (PropCalc (FOL a))
  deriving (Eq, Show)

data Command a =
  -- CSkip
  -- | CAssign a (Arith a)
  CAssign a (Arith a)
  | CSequence (Command a) (Command a)
  | CIfElse (PropCalc (FOL a)) (Command a) (Command a)
  | CWhile String (PropCalc (FOL a)) (Command a)
  -- | CAssert (PropCalc (FOL a)) (Command a) (PropCalc (FOL a))
  deriving (Show)

substFOL :: Eq a => FOL a -> a -> Arith a -> FOL a
substFOL (Eq a1 a2) v e = Eq (substArith a1 v e) (substArith a2 v e)
substFOL (Lt a1 a2) v e = Lt (substArith a1 v e) (substArith a2 v e)
substFOL (Gt a1 a2) v e = Gt (substArith a1 v e) (substArith a2 v e)
substFOL (Le a1 a2) v e = Le (substArith a1 v e) (substArith a2 v e)
substFOL (Ge a1 a2) v e = Ge (substArith a1 v e) (substArith a2 v e)

substFOL (ForAll x p) v e 
  | x == v    = ForAll x p
  | otherwise = ForAll x (subst p v e)
substFOL (Exists x p) v e 
  | x == v    = Exists x p
  | otherwise = Exists x (subst p v e)

subst :: Eq a => PropCalc (FOL a) -> a -> Arith a -> PropCalc (FOL a)
subst (PropVar f) v e = PropVar (substFOL f v e)
subst (Not p) v e     = Not (subst p v e)
subst (And p q) v e   = And (subst p v e) (subst q v e)
subst (Or p q) v e    = Or (subst p v e) (subst q v e)
subst (Imp p q) v e   = Imp (subst p v e) (subst q v e)

substArith :: Eq a => Arith a -> a -> Arith a -> Arith a
substArith (Var x) v e | x == v = e
substArith (Var x) _ _          = Var x
substArith Z _ _                = Z
substArith (S q) v e            = S (substArith q v e)
substArith (Plus a b) v e       = Plus (substArith a v e) (substArith b v e)
substArith (Minus a b) v e      = Minus (substArith a v e) (substArith b v e)
substArith (Mult a b) v e       = Mult (substArith a v e) (substArith b v e)
substArith (Max a b) v e        = Max (substArith a v e) (substArith b v e)