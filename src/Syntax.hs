module Syntax where

import Data.List ((\\), nub)

data Arith a =
  Var a
  | Z
  | S (Arith a)
  | Plus (Arith a) (Arith a)
  | Mult (Arith a) (Arith a)
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
  | ForAll a (PropCalc (FOL a))
  | Exists a (PropCalc (FOL a))
  deriving (Eq, Show)

data Command a =
  CSkip
  | CAssign a (Arith a)
  | CSequence (Command a) (Command a)
  | CIfElse (PropCalc (FOL a)) (Command a) (Command a)
  | CWhile (PropCalc (FOL a)) (Command a)
  | CAssert (PropCalc (FOL a)) (Command a) (PropCalc (FOL a))
  deriving (Show)

-- Substitution function for arithmetical formulas
substArith :: Eq a => Arith a -> Arith a -> Arith a -> Arith a
substArith (S q) v e = S (substArith q v e)
substArith (Plus a b) v e = Plus (substArith a v e) (substArith b v e)
substArith (Mult a b) v e = Mult (substArith a v e) (substArith b v e)
substArith x v e | x == v = e
substArith x v e = x

-- Substitution on equational level for a specific expression with another expression
substPropCalc :: Eq a => Proof (PropCalc (FOL a)) -> Arith a -> Arith a -> Proof (PropCalc (FOL a))
substPropCalc (Proof f) v e = Proof $ go f v e
  where
    go :: Eq a => PropCalc (FOL a) -> Arith a -> Arith a -> PropCalc (FOL a)
    go (PropVar (Eq a b)) v e     = PropVar (Eq (substArith a v e) (substArith b v e))
    go (PropVar (ForAll x y)) v e = PropVar (ForAll x (go y v e))
    go (PropVar (Exists x y)) v e = PropVar (Exists x (go y v e))
    go (Not x) v e                = Not (go x v e)
    go (And x y) v e              = And (go x v e) (go y v e)
    go (Or x y) v e               = Or (go x v e) (go y v e)
    go (Imp x y) v e              = Imp (go x v e) (go y v e)

-- Find bound variables in a formula
getBoundVars :: Eq a => PropCalc (FOL a) -> [a]
getBoundVars x = nub $ go x
  where
    go (PropVar (ForAll x y)) = x : go y
    go (PropVar (Exists x y)) = x : go y
    go _ = []

-- Get all variables used in an arithmetic formula
getArithVars :: Eq a => Arith a -> [a]
getArithVars x = nub $ go x
  where
    go (Var a) = [a]
    go (S x) = go x
    go (Plus a b) = go a ++ go b
    go (Mult a b) = go a ++ go b
    go _ = []

-- Get all used variables
getVars :: Eq a => PropCalc (FOL a) -> [a]
getVars x = nub $ go x
  where
    go (PropVar (ForAll x y)) = go y
    go (PropVar (Exists x y)) = go y
    go (PropVar (Eq a b)) = getArithVars a ++ getArithVars b
    go (Not x) = go x
    go (And x y) = go x ++ go y
    go (Or x y) = go x ++ go y
    go (Imp x y) = go x ++ go y

-- Get all free variables
getFreeVars :: Eq a => PropCalc (FOL a) -> [a]
getFreeVars x = getVars x \\ getBoundVars x