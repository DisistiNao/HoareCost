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
happyExpList = Happy_Data_Array.listArray (0,157) ([0,0,2,0,1024,3072,1545,32,0,0,0,0,64,0,0,0,7950,0,0,0,0,0,0,34304,772,16,2316,8198,2048,0,0,16,0,24576,12360,256,24576,0,4,15900,2048,0,0,64,0,32768,3072,1545,32,0,0,12288,0,128,96,0,49153,0,512,384,0,4,3,2048,1536,0,16,12,8192,6144,0,64,16,1184,0,0,4160,0,256,0,0,0,17152,386,8,8,0,57344,0,0,24,16384,32768,3,0,1792,0,0,14,0,7168,0,0,0,0,16384,0,0,128,0,0,0,0,0,32768,0,0,256,0,0,32768,49441,1024,17152,386,8,0,0,0,0,64,0,32768,12288,6180,128,18528,48,1,14,1024,8576,193,4,0,16,1536,0,16,2316,8198,2048,20480,2,0,0,0,0,1024,3584,0,32768,0,37,0,32768,0,0,8192,0,0,64,0,0,0,0,0,0,0,0,0,0,128,9472,0,0,33024,1536,0,16,224,4096,0,0,1,0,4096,8,0,0,64,4736,0,0,0,0,0,129,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","Prog","Prop","FOLExpr","Exp","Cmd","id","number","string","'+'","'-'","'*'","'not'","'and'","'or'","'implies'","'=='","'>'","'>='","'<'","'<='","'exists'","'forall'","'skip'","'='","'if'","'then'","'else'","'while'","'do'","'end'","'{'","'}'","'('","')'","'|'","'.'","';'","%eof"]
        bit_start = st * 41
        bit_end = (st + 1) * 41
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..40]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (34) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (34) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (9) = happyShift action_7
action_2 (10) = happyShift action_8
action_2 (15) = happyShift action_9
action_2 (18) = happyShift action_10
action_2 (24) = happyShift action_11
action_2 (25) = happyShift action_12
action_2 (36) = happyShift action_13
action_2 (5) = happyGoto action_4
action_2 (6) = happyGoto action_5
action_2 (7) = happyGoto action_6
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (41) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (35) = happyShift action_28
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
action_9 (36) = happyShift action_13
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
action_10 (36) = happyShift action_13
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
action_13 (36) = happyShift action_13
action_13 (5) = happyGoto action_14
action_13 (6) = happyGoto action_5
action_13 (7) = happyGoto action_15
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (16) = happyShift action_47
action_14 (17) = happyShift action_48
action_14 (37) = happyShift action_49
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (12) = happyShift action_20
action_15 (13) = happyShift action_21
action_15 (14) = happyShift action_22
action_15 (19) = happyShift action_23
action_15 (20) = happyShift action_24
action_15 (21) = happyShift action_25
action_15 (22) = happyShift action_26
action_15 (23) = happyShift action_27
action_15 (37) = happyShift action_46
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (39) = happyShift action_45
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (39) = happyShift action_44
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (9) = happyShift action_7
action_18 (10) = happyShift action_8
action_18 (15) = happyShift action_9
action_18 (18) = happyShift action_10
action_18 (24) = happyShift action_11
action_18 (25) = happyShift action_12
action_18 (36) = happyShift action_13
action_18 (5) = happyGoto action_43
action_18 (6) = happyGoto action_5
action_18 (7) = happyGoto action_6
action_18 _ = happyFail (happyExpListPerState 18)

action_19 _ = happyReduce_3

action_20 (9) = happyShift action_7
action_20 (10) = happyShift action_8
action_20 (36) = happyShift action_35
action_20 (7) = happyGoto action_42
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (9) = happyShift action_7
action_21 (10) = happyShift action_8
action_21 (36) = happyShift action_35
action_21 (7) = happyGoto action_41
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (9) = happyShift action_7
action_22 (10) = happyShift action_8
action_22 (36) = happyShift action_35
action_22 (7) = happyGoto action_40
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (9) = happyShift action_7
action_23 (10) = happyShift action_8
action_23 (36) = happyShift action_35
action_23 (7) = happyGoto action_39
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (9) = happyShift action_7
action_24 (10) = happyShift action_8
action_24 (36) = happyShift action_35
action_24 (7) = happyGoto action_38
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (9) = happyShift action_7
action_25 (10) = happyShift action_8
action_25 (36) = happyShift action_35
action_25 (7) = happyGoto action_37
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (9) = happyShift action_7
action_26 (10) = happyShift action_8
action_26 (36) = happyShift action_35
action_26 (7) = happyGoto action_36
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (9) = happyShift action_7
action_27 (10) = happyShift action_8
action_27 (36) = happyShift action_35
action_27 (7) = happyGoto action_34
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (9) = happyShift action_30
action_28 (26) = happyShift action_31
action_28 (28) = happyShift action_32
action_28 (31) = happyShift action_33
action_28 (8) = happyGoto action_29
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (34) = happyShift action_58
action_29 (40) = happyShift action_59
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (27) = happyShift action_57
action_30 _ = happyFail (happyExpListPerState 30)

action_31 _ = happyReduce_21

action_32 (9) = happyShift action_7
action_32 (10) = happyShift action_8
action_32 (15) = happyShift action_9
action_32 (18) = happyShift action_10
action_32 (24) = happyShift action_11
action_32 (25) = happyShift action_12
action_32 (36) = happyShift action_13
action_32 (5) = happyGoto action_56
action_32 (6) = happyGoto action_5
action_32 (7) = happyGoto action_6
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (11) = happyShift action_55
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (12) = happyShift action_20
action_34 (13) = happyShift action_21
action_34 (14) = happyShift action_22
action_34 _ = happyReduce_10

action_35 (9) = happyShift action_7
action_35 (10) = happyShift action_8
action_35 (36) = happyShift action_35
action_35 (7) = happyGoto action_54
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (12) = happyShift action_20
action_36 (13) = happyShift action_21
action_36 (14) = happyShift action_22
action_36 _ = happyReduce_9

action_37 (12) = happyShift action_20
action_37 (13) = happyShift action_21
action_37 (14) = happyShift action_22
action_37 _ = happyReduce_12

action_38 (12) = happyShift action_20
action_38 (13) = happyShift action_21
action_38 (14) = happyShift action_22
action_38 _ = happyReduce_11

action_39 (12) = happyShift action_20
action_39 (13) = happyShift action_21
action_39 (14) = happyShift action_22
action_39 _ = happyReduce_8

action_40 _ = happyReduce_20

action_41 (14) = happyShift action_22
action_41 _ = happyReduce_19

action_42 (14) = happyShift action_22
action_42 _ = happyReduce_18

action_43 _ = happyReduce_6

action_44 (36) = happyShift action_53
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (36) = happyShift action_52
action_45 _ = happyFail (happyExpListPerState 45)

action_46 _ = happyReduce_15

action_47 (9) = happyShift action_7
action_47 (10) = happyShift action_8
action_47 (15) = happyShift action_9
action_47 (18) = happyShift action_10
action_47 (24) = happyShift action_11
action_47 (25) = happyShift action_12
action_47 (36) = happyShift action_13
action_47 (5) = happyGoto action_51
action_47 (6) = happyGoto action_5
action_47 (7) = happyGoto action_6
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (9) = happyShift action_7
action_48 (10) = happyShift action_8
action_48 (15) = happyShift action_9
action_48 (18) = happyShift action_10
action_48 (24) = happyShift action_11
action_48 (25) = happyShift action_12
action_48 (36) = happyShift action_13
action_48 (5) = happyGoto action_50
action_48 (6) = happyGoto action_5
action_48 (7) = happyGoto action_6
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_2

action_50 (37) = happyShift action_68
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (37) = happyShift action_67
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (9) = happyShift action_7
action_52 (10) = happyShift action_8
action_52 (15) = happyShift action_9
action_52 (18) = happyShift action_10
action_52 (24) = happyShift action_11
action_52 (25) = happyShift action_12
action_52 (36) = happyShift action_13
action_52 (5) = happyGoto action_66
action_52 (6) = happyGoto action_5
action_52 (7) = happyGoto action_6
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (9) = happyShift action_7
action_53 (10) = happyShift action_8
action_53 (15) = happyShift action_9
action_53 (18) = happyShift action_10
action_53 (24) = happyShift action_11
action_53 (25) = happyShift action_12
action_53 (36) = happyShift action_13
action_53 (5) = happyGoto action_65
action_53 (6) = happyGoto action_5
action_53 (7) = happyGoto action_6
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (12) = happyShift action_20
action_54 (13) = happyShift action_21
action_54 (14) = happyShift action_22
action_54 (37) = happyShift action_46
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (9) = happyShift action_7
action_55 (10) = happyShift action_8
action_55 (15) = happyShift action_9
action_55 (18) = happyShift action_10
action_55 (24) = happyShift action_11
action_55 (25) = happyShift action_12
action_55 (36) = happyShift action_13
action_55 (5) = happyGoto action_64
action_55 (6) = happyGoto action_5
action_55 (7) = happyGoto action_6
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (29) = happyShift action_63
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (9) = happyShift action_7
action_57 (10) = happyShift action_8
action_57 (36) = happyShift action_35
action_57 (7) = happyGoto action_62
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (9) = happyShift action_7
action_58 (10) = happyShift action_8
action_58 (15) = happyShift action_9
action_58 (18) = happyShift action_10
action_58 (24) = happyShift action_11
action_58 (25) = happyShift action_12
action_58 (36) = happyShift action_13
action_58 (5) = happyGoto action_61
action_58 (6) = happyGoto action_5
action_58 (7) = happyGoto action_6
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (9) = happyShift action_30
action_59 (26) = happyShift action_31
action_59 (28) = happyShift action_32
action_59 (31) = happyShift action_33
action_59 (8) = happyGoto action_60
action_59 _ = happyFail (happyExpListPerState 59)

action_60 _ = happyReduce_25

action_61 (38) = happyShift action_73
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (12) = happyShift action_20
action_62 (13) = happyShift action_21
action_62 (14) = happyShift action_22
action_62 _ = happyReduce_22

action_63 (9) = happyShift action_30
action_63 (26) = happyShift action_31
action_63 (28) = happyShift action_32
action_63 (31) = happyShift action_33
action_63 (8) = happyGoto action_72
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (32) = happyShift action_71
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (37) = happyShift action_70
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (37) = happyShift action_69
action_66 _ = happyFail (happyExpListPerState 66)

action_67 _ = happyReduce_4

action_68 _ = happyReduce_5

action_69 _ = happyReduce_13

action_70 _ = happyReduce_14

action_71 (9) = happyShift action_30
action_71 (26) = happyShift action_31
action_71 (28) = happyShift action_32
action_71 (31) = happyShift action_33
action_71 (8) = happyGoto action_76
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (33) = happyShift action_75
action_72 (40) = happyShift action_59
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (9) = happyShift action_7
action_73 (10) = happyShift action_8
action_73 (36) = happyShift action_35
action_73 (7) = happyGoto action_74
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (12) = happyShift action_20
action_74 (13) = happyShift action_21
action_74 (14) = happyShift action_22
action_74 (35) = happyShift action_79
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (30) = happyShift action_78
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (33) = happyShift action_77
action_76 (40) = happyShift action_59
action_76 _ = happyFail (happyExpListPerState 76)

action_77 _ = happyReduce_24

action_78 (9) = happyShift action_30
action_78 (26) = happyShift action_31
action_78 (28) = happyShift action_32
action_78 (31) = happyShift action_33
action_78 (8) = happyGoto action_80
action_78 _ = happyFail (happyExpListPerState 78)

action_79 _ = happyReduce_1

action_80 (33) = happyShift action_81
action_80 (40) = happyShift action_59
action_80 _ = happyFail (happyExpListPerState 80)

action_81 _ = happyReduce_23

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

happyReduce_21 = happySpecReduce_1  8 happyReduction_21
happyReduction_21 _
	 =  HappyAbsSyn8
		 (CSkip
	)

happyReduce_22 = happySpecReduce_3  8 happyReduction_22
happyReduction_22 (HappyAbsSyn7  happy_var_3)
	_
	(HappyTerminal (Token _ (TIdent happy_var_1)))
	 =  HappyAbsSyn8
		 (CAssign (happy_var_1) (happy_var_3)
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happyReduce 8 8 happyReduction_23
happyReduction_23 (_ `HappyStk`
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

happyReduce_24 = happyReduce 6 8 happyReduction_24
happyReduction_24 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	(HappyTerminal (Token _ (TString happy_var_2))) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (CWhile (happy_var_2) (happy_var_3) (happy_var_5)
	) `HappyStk` happyRest

happyReduce_25 = happySpecReduce_3  8 happyReduction_25
happyReduction_25 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (CSequence (happy_var_1) (happy_var_3)
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	Token _ TEOF -> action 41 41 tk (HappyState action) sts stk;
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
	Token _ TSkip -> cont 26;
	Token _ TAssign -> cont 27;
	Token _ TIf -> cont 28;
	Token _ TThen -> cont 29;
	Token _ TElse -> cont 30;
	Token _ TWhile -> cont 31;
	Token _ TDo -> cont 32;
	Token _ TEnd -> cont 33;
	Token _ TLBracket -> cont 34;
	Token _ TRBracket -> cont 35;
	Token _ TLParen -> cont 36;
	Token _ TRParen -> cont 37;
	Token _ TBar -> cont 38;
	Token _ TDot -> cont 39;
	Token _ TSemicolons -> cont 40;
	_ -> happyError' (tk, [])
	})

happyError_ explist 41 tk = happyError' (tk, explist)
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
