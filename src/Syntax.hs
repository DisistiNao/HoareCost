module Syntax where

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