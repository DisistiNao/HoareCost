{-# OPTIONS_GHC -w #-}
module Parser.PropCalc (propCalcParser) where

import Lexer.Lexer hiding (lexer)
import Syntax
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.12

data HappyAbsSyn t4 t5 t6
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,153) ([57344,515,512,0,0,2,0,0,512,0,32,0,2,8192,57344,515,0,64,992,2,8254,57344,515,15872,32,64512,1,16384,0,512,0,32,0,2,8192,0,512,4,16384,0,0,16384,0,1024,0,64,0,4,0,0,512,0,32,0,2,0,0,512,0,32800,31,63490,8193,8064,512,504,32800,31,2,0,0,1024,4,0,0,63488,8193,0,512,0,32,0,63490,8193,0,1024,0,64,0,4,16384,57344,515,15872,32,992,2,8254,57344,515,0,64,0,4,16384,0,1024,0,64,0,2,8192,0,512,0,32,0,63492,8193,8064,512,504,32,0,63488,8193,0,0,0,32800,31,2,16384,0,1024,0,64,0,4,0,8064,512,504,32800,31,63490,8193,0,0,0,0,0,0,0,0,0,0,64,0,4,16384,0,1024,0,32,0,2,8192,0,0,0,64,0,63488,8193,8064,512,504,32,0,0,0,0,0,0,0,0,4,16384,0,1024,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","Prop","FOLExpr","Exp","id","'Var'","'Z'","'S'","'Plus'","'Minus'","'Mult'","'PropVar'","'Not'","'And'","'Or'","'Imp'","'Eq'","'Lt'","'Gt'","'Le'","'Ge'","'ForAll'","'Exists'","'('","')'","%eof"]
        bit_start = st * 28
        bit_end = (st + 1) * 28
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..27]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (14) = happyShift action_2
action_0 (15) = happyShift action_4
action_0 (16) = happyShift action_5
action_0 (17) = happyShift action_6
action_0 (18) = happyShift action_7
action_0 (26) = happyShift action_8
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (14) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (26) = happyShift action_14
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (28) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (26) = happyShift action_13
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (26) = happyShift action_12
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (26) = happyShift action_11
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (26) = happyShift action_10
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (14) = happyShift action_2
action_8 (15) = happyShift action_4
action_8 (16) = happyShift action_5
action_8 (17) = happyShift action_6
action_8 (18) = happyShift action_7
action_8 (26) = happyShift action_8
action_8 (4) = happyGoto action_9
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (27) = happyShift action_27
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (14) = happyShift action_2
action_10 (15) = happyShift action_4
action_10 (16) = happyShift action_5
action_10 (17) = happyShift action_6
action_10 (18) = happyShift action_7
action_10 (26) = happyShift action_8
action_10 (4) = happyGoto action_26
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (14) = happyShift action_2
action_11 (15) = happyShift action_4
action_11 (16) = happyShift action_5
action_11 (17) = happyShift action_6
action_11 (18) = happyShift action_7
action_11 (26) = happyShift action_8
action_11 (4) = happyGoto action_25
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (14) = happyShift action_2
action_12 (15) = happyShift action_4
action_12 (16) = happyShift action_5
action_12 (17) = happyShift action_6
action_12 (18) = happyShift action_7
action_12 (26) = happyShift action_8
action_12 (4) = happyGoto action_24
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (14) = happyShift action_2
action_13 (15) = happyShift action_4
action_13 (16) = happyShift action_5
action_13 (17) = happyShift action_6
action_13 (18) = happyShift action_7
action_13 (26) = happyShift action_8
action_13 (4) = happyGoto action_23
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (19) = happyShift action_16
action_14 (20) = happyShift action_17
action_14 (21) = happyShift action_18
action_14 (22) = happyShift action_19
action_14 (23) = happyShift action_20
action_14 (24) = happyShift action_21
action_14 (25) = happyShift action_22
action_14 (5) = happyGoto action_15
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (27) = happyShift action_39
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (26) = happyShift action_38
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (26) = happyShift action_37
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (26) = happyShift action_36
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (26) = happyShift action_35
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (26) = happyShift action_34
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (7) = happyShift action_33
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (7) = happyShift action_32
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (27) = happyShift action_31
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (27) = happyShift action_30
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (27) = happyShift action_29
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (27) = happyShift action_28
action_26 _ = happyFail (happyExpListPerState 26)

action_27 _ = happyReduce_6

action_28 (26) = happyShift action_56
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (26) = happyShift action_55
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (26) = happyShift action_54
action_30 _ = happyFail (happyExpListPerState 30)

action_31 _ = happyReduce_2

action_32 (26) = happyShift action_53
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (26) = happyShift action_52
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (8) = happyShift action_41
action_34 (9) = happyShift action_42
action_34 (10) = happyShift action_43
action_34 (11) = happyShift action_44
action_34 (12) = happyShift action_45
action_34 (13) = happyShift action_46
action_34 (26) = happyShift action_47
action_34 (6) = happyGoto action_51
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (8) = happyShift action_41
action_35 (9) = happyShift action_42
action_35 (10) = happyShift action_43
action_35 (11) = happyShift action_44
action_35 (12) = happyShift action_45
action_35 (13) = happyShift action_46
action_35 (26) = happyShift action_47
action_35 (6) = happyGoto action_50
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (8) = happyShift action_41
action_36 (9) = happyShift action_42
action_36 (10) = happyShift action_43
action_36 (11) = happyShift action_44
action_36 (12) = happyShift action_45
action_36 (13) = happyShift action_46
action_36 (26) = happyShift action_47
action_36 (6) = happyGoto action_49
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (8) = happyShift action_41
action_37 (9) = happyShift action_42
action_37 (10) = happyShift action_43
action_37 (11) = happyShift action_44
action_37 (12) = happyShift action_45
action_37 (13) = happyShift action_46
action_37 (26) = happyShift action_47
action_37 (6) = happyGoto action_48
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (8) = happyShift action_41
action_38 (9) = happyShift action_42
action_38 (10) = happyShift action_43
action_38 (11) = happyShift action_44
action_38 (12) = happyShift action_45
action_38 (13) = happyShift action_46
action_38 (26) = happyShift action_47
action_38 (6) = happyGoto action_40
action_38 _ = happyFail (happyExpListPerState 38)

action_39 _ = happyReduce_1

action_40 (27) = happyShift action_73
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (7) = happyShift action_72
action_41 _ = happyFail (happyExpListPerState 41)

action_42 _ = happyReduce_15

action_43 (8) = happyShift action_41
action_43 (9) = happyShift action_42
action_43 (10) = happyShift action_43
action_43 (11) = happyShift action_44
action_43 (12) = happyShift action_45
action_43 (13) = happyShift action_46
action_43 (26) = happyShift action_71
action_43 (6) = happyGoto action_70
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (26) = happyShift action_69
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (26) = happyShift action_68
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (26) = happyShift action_67
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (8) = happyShift action_41
action_47 (9) = happyShift action_42
action_47 (10) = happyShift action_43
action_47 (11) = happyShift action_44
action_47 (12) = happyShift action_45
action_47 (13) = happyShift action_46
action_47 (26) = happyShift action_47
action_47 (6) = happyGoto action_66
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (27) = happyShift action_65
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (27) = happyShift action_64
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (27) = happyShift action_63
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (27) = happyShift action_62
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (14) = happyShift action_2
action_52 (15) = happyShift action_4
action_52 (16) = happyShift action_5
action_52 (17) = happyShift action_6
action_52 (18) = happyShift action_7
action_52 (26) = happyShift action_8
action_52 (4) = happyGoto action_61
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (14) = happyShift action_2
action_53 (15) = happyShift action_4
action_53 (16) = happyShift action_5
action_53 (17) = happyShift action_6
action_53 (18) = happyShift action_7
action_53 (26) = happyShift action_8
action_53 (4) = happyGoto action_60
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (14) = happyShift action_2
action_54 (15) = happyShift action_4
action_54 (16) = happyShift action_5
action_54 (17) = happyShift action_6
action_54 (18) = happyShift action_7
action_54 (26) = happyShift action_8
action_54 (4) = happyGoto action_59
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (14) = happyShift action_2
action_55 (15) = happyShift action_4
action_55 (16) = happyShift action_5
action_55 (17) = happyShift action_6
action_55 (18) = happyShift action_7
action_55 (26) = happyShift action_8
action_55 (4) = happyGoto action_58
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (14) = happyShift action_2
action_56 (15) = happyShift action_4
action_56 (16) = happyShift action_5
action_56 (17) = happyShift action_6
action_56 (18) = happyShift action_7
action_56 (26) = happyShift action_8
action_56 (4) = happyGoto action_57
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (27) = happyShift action_88
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (27) = happyShift action_87
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (27) = happyShift action_86
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (27) = happyShift action_85
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (27) = happyShift action_84
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (26) = happyShift action_83
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (26) = happyShift action_82
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (26) = happyShift action_81
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (26) = happyShift action_80
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (27) = happyShift action_79
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (8) = happyShift action_41
action_67 (9) = happyShift action_42
action_67 (10) = happyShift action_43
action_67 (11) = happyShift action_44
action_67 (12) = happyShift action_45
action_67 (13) = happyShift action_46
action_67 (26) = happyShift action_47
action_67 (6) = happyGoto action_78
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (8) = happyShift action_41
action_68 (9) = happyShift action_42
action_68 (10) = happyShift action_43
action_68 (11) = happyShift action_44
action_68 (12) = happyShift action_45
action_68 (13) = happyShift action_46
action_68 (26) = happyShift action_47
action_68 (6) = happyGoto action_77
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (8) = happyShift action_41
action_69 (9) = happyShift action_42
action_69 (10) = happyShift action_43
action_69 (11) = happyShift action_44
action_69 (12) = happyShift action_45
action_69 (13) = happyShift action_46
action_69 (26) = happyShift action_47
action_69 (6) = happyGoto action_76
action_69 _ = happyFail (happyExpListPerState 69)

action_70 _ = happyReduce_16

action_71 (8) = happyShift action_41
action_71 (9) = happyShift action_42
action_71 (10) = happyShift action_43
action_71 (11) = happyShift action_44
action_71 (12) = happyShift action_45
action_71 (13) = happyShift action_46
action_71 (26) = happyShift action_47
action_71 (6) = happyGoto action_75
action_71 _ = happyFail (happyExpListPerState 71)

action_72 _ = happyReduce_14

action_73 (26) = happyShift action_74
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (8) = happyShift action_41
action_74 (9) = happyShift action_42
action_74 (10) = happyShift action_43
action_74 (11) = happyShift action_44
action_74 (12) = happyShift action_45
action_74 (13) = happyShift action_46
action_74 (26) = happyShift action_47
action_74 (6) = happyGoto action_97
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (27) = happyShift action_96
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (27) = happyShift action_95
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (27) = happyShift action_94
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (27) = happyShift action_93
action_78 _ = happyFail (happyExpListPerState 78)

action_79 _ = happyReduce_21

action_80 (8) = happyShift action_41
action_80 (9) = happyShift action_42
action_80 (10) = happyShift action_43
action_80 (11) = happyShift action_44
action_80 (12) = happyShift action_45
action_80 (13) = happyShift action_46
action_80 (26) = happyShift action_47
action_80 (6) = happyGoto action_92
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (8) = happyShift action_41
action_81 (9) = happyShift action_42
action_81 (10) = happyShift action_43
action_81 (11) = happyShift action_44
action_81 (12) = happyShift action_45
action_81 (13) = happyShift action_46
action_81 (26) = happyShift action_47
action_81 (6) = happyGoto action_91
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (8) = happyShift action_41
action_82 (9) = happyShift action_42
action_82 (10) = happyShift action_43
action_82 (11) = happyShift action_44
action_82 (12) = happyShift action_45
action_82 (13) = happyShift action_46
action_82 (26) = happyShift action_47
action_82 (6) = happyGoto action_90
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (8) = happyShift action_41
action_83 (9) = happyShift action_42
action_83 (10) = happyShift action_43
action_83 (11) = happyShift action_44
action_83 (12) = happyShift action_45
action_83 (13) = happyShift action_46
action_83 (26) = happyShift action_47
action_83 (6) = happyGoto action_89
action_83 _ = happyFail (happyExpListPerState 83)

action_84 _ = happyReduce_12

action_85 _ = happyReduce_13

action_86 _ = happyReduce_3

action_87 _ = happyReduce_4

action_88 _ = happyReduce_5

action_89 (27) = happyShift action_105
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (27) = happyShift action_104
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (27) = happyShift action_103
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (27) = happyShift action_102
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (26) = happyShift action_101
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (26) = happyShift action_100
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (26) = happyShift action_99
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (27) = happyReduce_21
action_96 _ = happyReduce_21

action_97 (27) = happyShift action_98
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_7

action_99 (8) = happyShift action_41
action_99 (9) = happyShift action_42
action_99 (10) = happyShift action_43
action_99 (11) = happyShift action_44
action_99 (12) = happyShift action_45
action_99 (13) = happyShift action_46
action_99 (26) = happyShift action_47
action_99 (6) = happyGoto action_108
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (8) = happyShift action_41
action_100 (9) = happyShift action_42
action_100 (10) = happyShift action_43
action_100 (11) = happyShift action_44
action_100 (12) = happyShift action_45
action_100 (13) = happyShift action_46
action_100 (26) = happyShift action_47
action_100 (6) = happyGoto action_107
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (8) = happyShift action_41
action_101 (9) = happyShift action_42
action_101 (10) = happyShift action_43
action_101 (11) = happyShift action_44
action_101 (12) = happyShift action_45
action_101 (13) = happyShift action_46
action_101 (26) = happyShift action_47
action_101 (6) = happyGoto action_106
action_101 _ = happyFail (happyExpListPerState 101)

action_102 _ = happyReduce_8

action_103 _ = happyReduce_9

action_104 _ = happyReduce_10

action_105 _ = happyReduce_11

action_106 (27) = happyShift action_111
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (27) = happyShift action_110
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (27) = happyShift action_109
action_108 _ = happyFail (happyExpListPerState 108)

action_109 _ = happyReduce_18

action_110 _ = happyReduce_19

action_111 _ = happyReduce_20

happyReduce_1 = happyReduce 4 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (PropVar happy_var_3
	) `HappyStk` happyRest

happyReduce_2 = happyReduce 4 4 happyReduction_2
happyReduction_2 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Not happy_var_3
	) `HappyStk` happyRest

happyReduce_3 = happyReduce 7 4 happyReduction_3
happyReduction_3 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (And happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_4 = happyReduce 7 4 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Or happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 7 4 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Imp happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_3  4 happyReduction_6
happyReduction_6 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happyReduce 7 5 happyReduction_7
happyReduction_7 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Eq happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 7 5 happyReduction_8
happyReduction_8 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Lt happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 7 5 happyReduction_9
happyReduction_9 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Gt happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_10 = happyReduce 7 5 happyReduction_10
happyReduction_10 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Le happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 7 5 happyReduction_11
happyReduction_11 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Ge happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_12 = happyReduce 5 5 happyReduction_12
happyReduction_12 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token _ (TIdent happy_var_2))) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (ForAll happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_13 = happyReduce 5 5 happyReduction_13
happyReduction_13 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (Token _ (TIdent happy_var_2))) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Exists happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_14 = happySpecReduce_2  6 happyReduction_14
happyReduction_14 (HappyTerminal (Token _ (TIdent happy_var_2)))
	_
	 =  HappyAbsSyn6
		 (Var happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  6 happyReduction_15
happyReduction_15 _
	 =  HappyAbsSyn6
		 (Z
	)

happyReduce_16 = happySpecReduce_2  6 happyReduction_16
happyReduction_16 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (S happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happyReduce 4 6 happyReduction_17
happyReduction_17 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (S happy_var_3
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 7 6 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Plus happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 7 6 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Minus happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 7 6 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Mult happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_21 = happySpecReduce_3  6 happyReduction_21
happyReduction_21 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (happy_var_2
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	Token _ TEOF -> action 28 28 tk (HappyState action) sts stk;
	Token _ (TIdent happy_dollar_dollar) -> cont 7;
	Token _ TVar -> cont 8;
	Token _ TZero -> cont 9;
	Token _ TSucc -> cont 10;
	Token _ TPlus -> cont 11;
	Token _ TMinus -> cont 12;
	Token _ TMult -> cont 13;
	Token _ TPropVar -> cont 14;
	Token _ TNot -> cont 15;
	Token _ TAnd -> cont 16;
	Token _ TOr -> cont 17;
	Token _ TImp -> cont 18;
	Token _ TEq -> cont 19;
	Token _ TLt -> cont 20;
	Token _ TGt -> cont 21;
	Token _ TLe -> cont 22;
	Token _ TGe -> cont 23;
	Token _ TForAll -> cont 24;
	Token _ TExists -> cont 25;
	Token _ TLParen -> cont 26;
	Token _ TRParen -> cont 27;
	_ -> happyError' (tk, [])
	})

happyError_ explist 28 tk = happyError' (tk, explist)
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


parseError :: Token -> Alex a
parseError (Token (l,c) lex)
  = alexError $
      "Parse error at line " ++ show l ++
      ", column " ++ show c ++
      "\nUnexpected token: " ++ show lex

lexer :: (Token -> Alex a) -> Alex a
lexer = (=<< alexMonadScan)

propCalcParser :: String -> Either String (PropCalc (FOL String))
propCalcParser input =
  runAlex input parser
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
