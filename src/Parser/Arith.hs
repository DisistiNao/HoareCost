{-# OPTIONS_GHC -w #-}
module Parser.Arith (arithParser) where

import Lexer.Lexer hiding (lexer)
import Syntax
import Variables
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.12

data HappyAbsSyn t4
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,63) ([8128,32,4,0,0,254,64,32,57360,15,63496,64515,65025,0,16256,0,4096,2048,1024,512,0,64,32,16,61440,63495,64515,1,32769,16384,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","Exp","id","num","'Var'","'Z'","'S'","'Plus'","'Minus'","'Mult'","'('","')'","%eof"]
        bit_start = st * 15
        bit_end = (st + 1) * 15
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..14]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (7) = happyShift action_2
action_0 (8) = happyShift action_4
action_0 (9) = happyShift action_5
action_0 (10) = happyShift action_6
action_0 (11) = happyShift action_7
action_0 (12) = happyShift action_8
action_0 (13) = happyShift action_9
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (7) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (5) = happyShift action_16
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (15) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_2

action_5 (7) = happyShift action_2
action_5 (8) = happyShift action_4
action_5 (9) = happyShift action_5
action_5 (10) = happyShift action_6
action_5 (11) = happyShift action_7
action_5 (12) = happyShift action_8
action_5 (13) = happyShift action_15
action_5 (4) = happyGoto action_14
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (13) = happyShift action_13
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (13) = happyShift action_12
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (13) = happyShift action_11
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (7) = happyShift action_2
action_9 (8) = happyShift action_4
action_9 (9) = happyShift action_5
action_9 (10) = happyShift action_6
action_9 (11) = happyShift action_7
action_9 (12) = happyShift action_8
action_9 (13) = happyShift action_9
action_9 (4) = happyGoto action_10
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (14) = happyShift action_21
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (7) = happyShift action_2
action_11 (8) = happyShift action_4
action_11 (9) = happyShift action_5
action_11 (10) = happyShift action_6
action_11 (11) = happyShift action_7
action_11 (12) = happyShift action_8
action_11 (13) = happyShift action_9
action_11 (4) = happyGoto action_20
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (7) = happyShift action_2
action_12 (8) = happyShift action_4
action_12 (9) = happyShift action_5
action_12 (10) = happyShift action_6
action_12 (11) = happyShift action_7
action_12 (12) = happyShift action_8
action_12 (13) = happyShift action_9
action_12 (4) = happyGoto action_19
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (7) = happyShift action_2
action_13 (8) = happyShift action_4
action_13 (9) = happyShift action_5
action_13 (10) = happyShift action_6
action_13 (11) = happyShift action_7
action_13 (12) = happyShift action_8
action_13 (13) = happyShift action_9
action_13 (4) = happyGoto action_18
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_3

action_15 (7) = happyShift action_2
action_15 (8) = happyShift action_4
action_15 (9) = happyShift action_5
action_15 (10) = happyShift action_6
action_15 (11) = happyShift action_7
action_15 (12) = happyShift action_8
action_15 (13) = happyShift action_9
action_15 (4) = happyGoto action_17
action_15 _ = happyFail (happyExpListPerState 15)

action_16 _ = happyReduce_1

action_17 (14) = happyShift action_25
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (14) = happyShift action_24
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (14) = happyShift action_23
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (14) = happyShift action_22
action_20 _ = happyFail (happyExpListPerState 20)

action_21 _ = happyReduce_8

action_22 (13) = happyShift action_28
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (13) = happyShift action_27
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (13) = happyShift action_26
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (14) = happyReduce_8
action_25 (15) = happyReduce_8
action_25 _ = happyReduce_8

action_26 (7) = happyShift action_2
action_26 (8) = happyShift action_4
action_26 (9) = happyShift action_5
action_26 (10) = happyShift action_6
action_26 (11) = happyShift action_7
action_26 (12) = happyShift action_8
action_26 (13) = happyShift action_9
action_26 (4) = happyGoto action_31
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (7) = happyShift action_2
action_27 (8) = happyShift action_4
action_27 (9) = happyShift action_5
action_27 (10) = happyShift action_6
action_27 (11) = happyShift action_7
action_27 (12) = happyShift action_8
action_27 (13) = happyShift action_9
action_27 (4) = happyGoto action_30
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (7) = happyShift action_2
action_28 (8) = happyShift action_4
action_28 (9) = happyShift action_5
action_28 (10) = happyShift action_6
action_28 (11) = happyShift action_7
action_28 (12) = happyShift action_8
action_28 (13) = happyShift action_9
action_28 (4) = happyGoto action_29
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (14) = happyShift action_34
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (14) = happyShift action_33
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (14) = happyShift action_32
action_31 _ = happyFail (happyExpListPerState 31)

action_32 _ = happyReduce_5

action_33 _ = happyReduce_6

action_34 _ = happyReduce_7

happyReduce_1 = happySpecReduce_2  4 happyReduction_1
happyReduction_1 (HappyTerminal (Token _ (TIdent happy_var_2)))
	_
	 =  HappyAbsSyn4
		 (Var happy_var_2
	)
happyReduction_1 _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 _
	 =  HappyAbsSyn4
		 (Z
	)

happyReduce_3 = happySpecReduce_2  4 happyReduction_3
happyReduction_3 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (S happy_var_2
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happyReduce 4 4 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (S happy_var_3
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
		 (Plus happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 7 4 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Minus happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 7 4 happyReduction_7
happyReduction_7 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Mult happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_3  4 happyReduction_8
happyReduction_8 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = action i i tk (HappyState action) sts stk in
	case tk of {
	Token _ TEOF -> action 15 15 tk (HappyState action) sts stk;
	Token _ (TIdent happy_dollar_dollar) -> cont 5;
	Token _ (TNumber happy_dollar_dollar) -> cont 6;
	Token _ TVar -> cont 7;
	Token _ TZero -> cont 8;
	Token _ TSucc -> cont 9;
	Token _ TPlus -> cont 10;
	Token _ TMinus -> cont 11;
	Token _ TMult -> cont 12;
	Token _ TLParen -> cont 13;
	Token _ TRParen -> cont 14;
	_ -> happyError' (tk, [])
	})

happyError_ explist 15 tk = happyError' (tk, explist)
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

lexer :: (Token -> Alex a) -> Alex a
lexer = (=<< alexMonadScan)

arithParser :: String -> Either String (Arith Vars)
arithParser input 
  = runAlex input parser
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
