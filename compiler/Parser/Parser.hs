{-# OPTIONS_GHC -w #-}
module Parser.Parser (run) where

import Lexer.Lexer hiding (lexer)
import Syntax
import Variables
import VCGen
import Solver (proveVCs)
import Utils (num)
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.12

data HappyAbsSyn t4 t5 t6 t7 t8
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,156) ([0,0,1,0,256,17152,386,4,0,0,0,0,2,0,0,14336,124,0,0,0,0,0,0,33347,1025,17152,386,4,1,0,256,0,0,33347,1025,32768,1,8,31800,2048,0,0,32,0,8192,17152,386,4,0,0,768,0,4,3,1024,768,0,4,3,1024,768,0,4,3,1024,768,0,4,3,1024,256,9216,0,0,16640,0,512,0,33347,1025,1024,0,0,56,0,768,0,4,56,0,14336,0,0,56,0,14336,0,0,0,0,8192,0,0,32,0,0,0,0,0,1024,0,0,4,0,0,17152,386,4,33347,1025,0,0,0,0,2048,0,0,8,33347,1025,17152,386,4,56,2048,17152,386,4,0,8,768,0,4,33347,1025,256,9216,0,0,0,0,0,16,56,0,256,9216,0,0,64,0,0,8,0,2048,0,0,0,0,0,0,0,0,0,0,256,9216,0,0,16512,768,0,4,56,512,0,4096,0,0,16512,0,0,0,1,36,0,0,0,0,16512,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","Prog","Prop","FOLExpr","Exp","Cmd","id","number","string","'+'","'-'","'*'","'not'","'and'","'or'","'implies'","'=='","'>'","'>='","'<'","'<='","'exists'","'forall'","'='","'if'","'then'","'else'","'while'","'do'","'end'","'{'","'}'","'('","')'","'|'","'.'","';'","%eof"]
        bit_start = st * 40
        bit_end = (st + 1) * 40
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..39]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (33) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (33) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (9) = happyShift action_7
action_2 (10) = happyShift action_8
action_2 (15) = happyShift action_9
action_2 (18) = happyShift action_10
action_2 (24) = happyShift action_11
action_2 (25) = happyShift action_12
action_2 (35) = happyShift action_13
action_2 (5) = happyGoto action_4
action_2 (6) = happyGoto action_5
action_2 (7) = happyGoto action_6
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (40) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (34) = happyShift action_28
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_7

action_6 (12) = happyShift action_20
action_6 (13) = happyShift action_21
action_6 (14) = happyShift action_22
action_6 (19) = happyShift action_23
action_6 (20) = happyShift action_24
action_6 (21) = happyShift action_25
action_6 (22) = happyShift action_26
action_6 (23) = happyShift action_27
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_16

action_8 _ = happyReduce_17

action_9 (9) = happyShift action_7
action_9 (10) = happyShift action_8
action_9 (15) = happyShift action_9
action_9 (18) = happyShift action_10
action_9 (24) = happyShift action_11
action_9 (25) = happyShift action_12
action_9 (35) = happyShift action_13
action_9 (5) = happyGoto action_19
action_9 (6) = happyGoto action_5
action_9 (7) = happyGoto action_6
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (9) = happyShift action_7
action_10 (10) = happyShift action_8
action_10 (15) = happyShift action_9
action_10 (18) = happyShift action_10
action_10 (24) = happyShift action_11
action_10 (25) = happyShift action_12
action_10 (35) = happyShift action_13
action_10 (5) = happyGoto action_18
action_10 (6) = happyGoto action_5
action_10 (7) = happyGoto action_6
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (9) = happyShift action_17
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (9) = happyShift action_16
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (9) = happyShift action_7
action_13 (10) = happyShift action_8
action_13 (15) = happyShift action_9
action_13 (18) = happyShift action_10
action_13 (24) = happyShift action_11
action_13 (25) = happyShift action_12
action_13 (35) = happyShift action_13
action_13 (5) = happyGoto action_14
action_13 (6) = happyGoto action_5
action_13 (7) = happyGoto action_15
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (16) = happyShift action_46
action_14 (17) = happyShift action_47
action_14 (36) = happyShift action_48
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (12) = happyShift action_20
action_15 (13) = happyShift action_21
action_15 (14) = happyShift action_22
action_15 (19) = happyShift action_23
action_15 (20) = happyShift action_24
action_15 (21) = happyShift action_25
action_15 (22) = happyShift action_26
action_15 (23) = happyShift action_27
action_15 (36) = happyShift action_45
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (38) = happyShift action_44
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (38) = happyShift action_43
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (9) = happyShift action_7
action_18 (10) = happyShift action_8
action_18 (15) = happyShift action_9
action_18 (18) = happyShift action_10
action_18 (24) = happyShift action_11
action_18 (25) = happyShift action_12
action_18 (35) = happyShift action_13
action_18 (5) = happyGoto action_42
action_18 (6) = happyGoto action_5
action_18 (7) = happyGoto action_6
action_18 _ = happyFail (happyExpListPerState 18)

action_19 _ = happyReduce_3

action_20 (9) = happyShift action_7
action_20 (10) = happyShift action_8
action_20 (35) = happyShift action_34
action_20 (7) = happyGoto action_41
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (9) = happyShift action_7
action_21 (10) = happyShift action_8
action_21 (35) = happyShift action_34
action_21 (7) = happyGoto action_40
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (9) = happyShift action_7
action_22 (10) = happyShift action_8
action_22 (35) = happyShift action_34
action_22 (7) = happyGoto action_39
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (9) = happyShift action_7
action_23 (10) = happyShift action_8
action_23 (35) = happyShift action_34
action_23 (7) = happyGoto action_38
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (9) = happyShift action_7
action_24 (10) = happyShift action_8
action_24 (35) = happyShift action_34
action_24 (7) = happyGoto action_37
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (9) = happyShift action_7
action_25 (10) = happyShift action_8
action_25 (35) = happyShift action_34
action_25 (7) = happyGoto action_36
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (9) = happyShift action_7
action_26 (10) = happyShift action_8
action_26 (35) = happyShift action_34
action_26 (7) = happyGoto action_35
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (9) = happyShift action_7
action_27 (10) = happyShift action_8
action_27 (35) = happyShift action_34
action_27 (7) = happyGoto action_33
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (9) = happyShift action_30
action_28 (27) = happyShift action_31
action_28 (30) = happyShift action_32
action_28 (8) = happyGoto action_29
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (33) = happyShift action_57
action_29 (39) = happyShift action_58
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (26) = happyShift action_56
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (9) = happyShift action_7
action_31 (10) = happyShift action_8
action_31 (15) = happyShift action_9
action_31 (18) = happyShift action_10
action_31 (24) = happyShift action_11
action_31 (25) = happyShift action_12
action_31 (35) = happyShift action_13
action_31 (5) = happyGoto action_55
action_31 (6) = happyGoto action_5
action_31 (7) = happyGoto action_6
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (11) = happyShift action_54
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (12) = happyShift action_20
action_33 (13) = happyShift action_21
action_33 (14) = happyShift action_22
action_33 _ = happyReduce_10

action_34 (9) = happyShift action_7
action_34 (10) = happyShift action_8
action_34 (35) = happyShift action_34
action_34 (7) = happyGoto action_53
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (12) = happyShift action_20
action_35 (13) = happyShift action_21
action_35 (14) = happyShift action_22
action_35 _ = happyReduce_9

action_36 (12) = happyShift action_20
action_36 (13) = happyShift action_21
action_36 (14) = happyShift action_22
action_36 _ = happyReduce_12

action_37 (12) = happyShift action_20
action_37 (13) = happyShift action_21
action_37 (14) = happyShift action_22
action_37 _ = happyReduce_11

action_38 (12) = happyShift action_20
action_38 (13) = happyShift action_21
action_38 (14) = happyShift action_22
action_38 _ = happyReduce_8

action_39 _ = happyReduce_20

action_40 (14) = happyShift action_22
action_40 _ = happyReduce_19

action_41 (14) = happyShift action_22
action_41 _ = happyReduce_18

action_42 _ = happyReduce_6

action_43 (35) = happyShift action_52
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (35) = happyShift action_51
action_44 _ = happyFail (happyExpListPerState 44)

action_45 _ = happyReduce_15

action_46 (9) = happyShift action_7
action_46 (10) = happyShift action_8
action_46 (15) = happyShift action_9
action_46 (18) = happyShift action_10
action_46 (24) = happyShift action_11
action_46 (25) = happyShift action_12
action_46 (35) = happyShift action_13
action_46 (5) = happyGoto action_50
action_46 (6) = happyGoto action_5
action_46 (7) = happyGoto action_6
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (9) = happyShift action_7
action_47 (10) = happyShift action_8
action_47 (15) = happyShift action_9
action_47 (18) = happyShift action_10
action_47 (24) = happyShift action_11
action_47 (25) = happyShift action_12
action_47 (35) = happyShift action_13
action_47 (5) = happyGoto action_49
action_47 (6) = happyGoto action_5
action_47 (7) = happyGoto action_6
action_47 _ = happyFail (happyExpListPerState 47)

action_48 _ = happyReduce_2

action_49 (36) = happyShift action_67
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (36) = happyShift action_66
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (9) = happyShift action_7
action_51 (10) = happyShift action_8
action_51 (15) = happyShift action_9
action_51 (18) = happyShift action_10
action_51 (24) = happyShift action_11
action_51 (25) = happyShift action_12
action_51 (35) = happyShift action_13
action_51 (5) = happyGoto action_65
action_51 (6) = happyGoto action_5
action_51 (7) = happyGoto action_6
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (9) = happyShift action_7
action_52 (10) = happyShift action_8
action_52 (15) = happyShift action_9
action_52 (18) = happyShift action_10
action_52 (24) = happyShift action_11
action_52 (25) = happyShift action_12
action_52 (35) = happyShift action_13
action_52 (5) = happyGoto action_64
action_52 (6) = happyGoto action_5
action_52 (7) = happyGoto action_6
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (12) = happyShift action_20
action_53 (13) = happyShift action_21
action_53 (14) = happyShift action_22
action_53 (36) = happyShift action_45
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (9) = happyShift action_7
action_54 (10) = happyShift action_8
action_54 (15) = happyShift action_9
action_54 (18) = happyShift action_10
action_54 (24) = happyShift action_11
action_54 (25) = happyShift action_12
action_54 (35) = happyShift action_13
action_54 (5) = happyGoto action_63
action_54 (6) = happyGoto action_5
action_54 (7) = happyGoto action_6
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (28) = happyShift action_62
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (9) = happyShift action_7
action_56 (10) = happyShift action_8
action_56 (35) = happyShift action_34
action_56 (7) = happyGoto action_61
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (9) = happyShift action_7
action_57 (10) = happyShift action_8
action_57 (15) = happyShift action_9
action_57 (18) = happyShift action_10
action_57 (24) = happyShift action_11
action_57 (25) = happyShift action_12
action_57 (35) = happyShift action_13
action_57 (5) = happyGoto action_60
action_57 (6) = happyGoto action_5
action_57 (7) = happyGoto action_6
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (9) = happyShift action_30
action_58 (27) = happyShift action_31
action_58 (30) = happyShift action_32
action_58 (8) = happyGoto action_59
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_24

action_60 (37) = happyShift action_72
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (12) = happyShift action_20
action_61 (13) = happyShift action_21
action_61 (14) = happyShift action_22
action_61 _ = happyReduce_21

action_62 (9) = happyShift action_30
action_62 (27) = happyShift action_31
action_62 (30) = happyShift action_32
action_62 (8) = happyGoto action_71
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (31) = happyShift action_70
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (36) = happyShift action_69
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (36) = happyShift action_68
action_65 _ = happyFail (happyExpListPerState 65)

action_66 _ = happyReduce_4

action_67 _ = happyReduce_5

action_68 _ = happyReduce_13

action_69 _ = happyReduce_14

action_70 (9) = happyShift action_30
action_70 (27) = happyShift action_31
action_70 (30) = happyShift action_32
action_70 (8) = happyGoto action_75
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (32) = happyShift action_74
action_71 (39) = happyShift action_58
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (9) = happyShift action_7
action_72 (10) = happyShift action_8
action_72 (35) = happyShift action_34
action_72 (7) = happyGoto action_73
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (12) = happyShift action_20
action_73 (13) = happyShift action_21
action_73 (14) = happyShift action_22
action_73 (34) = happyShift action_78
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (29) = happyShift action_77
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (32) = happyShift action_76
action_75 (39) = happyShift action_58
action_75 _ = happyFail (happyExpListPerState 75)

action_76 _ = happyReduce_23

action_77 (9) = happyShift action_30
action_77 (27) = happyShift action_31
action_77 (30) = happyShift action_32
action_77 (8) = happyGoto action_79
action_77 _ = happyFail (happyExpListPerState 77)

action_78 _ = happyReduce_1

action_79 (32) = happyShift action_80
action_79 (39) = happyShift action_58
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_22

happyReduce_1 = happyReduce 9 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (HCLang happy_var_2 happy_var_4 happy_var_6 happy_var_8
	) `HappyStk` happyRest

happyReduce_2 = happySpecReduce_3  5 happyReduction_2
happyReduction_2 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (happy_var_2
	)
happyReduction_2 _ _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_2  5 happyReduction_3
happyReduction_3 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (Not (happy_var_2)
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happyReduce 5 5 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (And (happy_var_2) (happy_var_4)
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 5 5 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Or (happy_var_2) (happy_var_4)
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_3  5 happyReduction_6
happyReduction_6 (HappyAbsSyn5  happy_var_3)
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (Imp (happy_var_2) (happy_var_3)
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  5 happyReduction_7
happyReduction_7 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (PropVar (happy_var_1)
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  6 happyReduction_8
happyReduction_8 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (Eq (happy_var_1) (happy_var_3)
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  6 happyReduction_9
happyReduction_9 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (Lt (happy_var_1) (happy_var_3)
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  6 happyReduction_10
happyReduction_10 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (Le (happy_var_1) (happy_var_3)
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  6 happyReduction_11
happyReduction_11 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (Gt (happy_var_1) (happy_var_3)
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  6 happyReduction_12
happyReduction_12 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (Ge (happy_var_1) (happy_var_3)
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happyReduce 6 6 happyReduction_13
happyReduction_13 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token _ (TIdent happy_var_2))) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (ForAll (happy_var_2) (happy_var_5)
	) `HappyStk` happyRest

happyReduce_14 = happyReduce 6 6 happyReduction_14
happyReduction_14 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token _ (TIdent happy_var_2))) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Exists (happy_var_2) (happy_var_5)
	) `HappyStk` happyRest

happyReduce_15 = happySpecReduce_3  7 happyReduction_15
happyReduction_15 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 ((happy_var_2)
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  7 happyReduction_16
happyReduction_16 (HappyTerminal (Token _ (TIdent happy_var_1)))
	 =  HappyAbsSyn7
		 (Var (happy_var_1)
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  7 happyReduction_17
happyReduction_17 (HappyTerminal (Token _ (TNumber happy_var_1)))
	 =  HappyAbsSyn7
		 ((num happy_var_1)
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  7 happyReduction_18
happyReduction_18 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Plus (happy_var_1) (happy_var_3)
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  7 happyReduction_19
happyReduction_19 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Minus (happy_var_1) (happy_var_3)
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  7 happyReduction_20
happyReduction_20 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Mult (happy_var_1) (happy_var_3)
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  8 happyReduction_21
happyReduction_21 (HappyAbsSyn7  happy_var_3)
	_
	(HappyTerminal (Token _ (TIdent happy_var_1)))
	 =  HappyAbsSyn8
		 (CAssign (happy_var_1) (happy_var_3)
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happyReduce 8 8 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (CIfElse (happy_var_2) (happy_var_4) (happy_var_7)
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 6 8 happyReduction_23
happyReduction_23 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	(HappyTerminal (Token _ (TString happy_var_2))) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (CWhile (happy_var_2) (happy_var_3) (happy_var_5)
	) `HappyStk` happyRest

happyReduce_24 = happySpecReduce_3  8 happyReduction_24
happyReduction_24 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (CSequence (happy_var_1) (happy_var_3)
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	Token _ TEOF -> action 40 40 tk (HappyState action) sts stk;
	Token _ (TIdent happy_dollar_dollar) -> cont 9;
	Token _ (TNumber happy_dollar_dollar) -> cont 10;
	Token _ (TString happy_dollar_dollar) -> cont 11;
	Token _ TPlus -> cont 12;
	Token _ TMinus -> cont 13;
	Token _ TMult -> cont 14;
	Token _ TNot -> cont 15;
	Token _ TAnd -> cont 16;
	Token _ TOr -> cont 17;
	Token _ TImp -> cont 18;
	Token _ TEq -> cont 19;
	Token _ TGt -> cont 20;
	Token _ TGe -> cont 21;
	Token _ TLt -> cont 22;
	Token _ TLe -> cont 23;
	Token _ TExists -> cont 24;
	Token _ TForAll -> cont 25;
	Token _ TAssign -> cont 26;
	Token _ TIf -> cont 27;
	Token _ TThen -> cont 28;
	Token _ TElse -> cont 29;
	Token _ TWhile -> cont 30;
	Token _ TDo -> cont 31;
	Token _ TEnd -> cont 32;
	Token _ TLBracket -> cont 33;
	Token _ TRBracket -> cont 34;
	Token _ TLParen -> cont 35;
	Token _ TRParen -> cont 36;
	Token _ TBar -> cont 37;
	Token _ TDot -> cont 38;
	Token _ TSemicolons -> cont 39;
	_ -> happyError' (tk, [])
	})

happyError_ explist 40 tk = happyError' (tk, explist)
happyError_ explist _ tk = happyError' (tk, explist)

happyThen :: () => Alex a -> (a -> Alex b) -> Alex b
happyThen = ((>>=))
happyReturn :: () => a -> Alex a
happyReturn = (return)
happyThen1 :: () => Alex a -> (a -> Alex b) -> Alex b
happyThen1 = happyThen
happyReturn1 :: () => a -> Alex a
happyReturn1 = happyReturn
happyError' :: () => ((Token), [String]) -> Alex a
happyError' tk = (\(tokens, _) -> parseError tokens) tk
parser = happySomeParser where
 happySomeParser = happyThen (happyParse action_0) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError (Token (line, col) lexeme)
  = alexError $ "Parse error while processing lexeme: " ++ show lexeme
                ++ "\n at line " ++ show line ++ ", column " ++ show col

data HCLang a = HCLang (PropCalc (FOL a)) (Command a) (PropCalc (FOL a)) (Arith a)

lexer :: (Token -> Alex a) -> Alex a
lexer = (=<< alexMonadScan)

hcParser :: String -> Either String (HCLang Vars)
hcParser input 
  = runAlex input parser 

run :: String -> IO ()
run input = do
  putStrLn "Generating VCs for the program..."

  case hcParser input of
    Left err ->
      putStrLn ("Parse error: " ++ err)

    Right (HCLang pre cmd post custoAlvo) -> do
      vcs <- vcg pre cmd post custoAlvo
      proveVCs vcs
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
