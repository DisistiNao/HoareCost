{
{-# OPTIONS_GHC -Wno-name-shadowing #-}
module Lexer.Lexer where

import Control.Monad
import Text.Read (readMaybe)
import Variables
}


%wrapper "monadUserState"

$digit = 0-9            -- digits
$alpha = [a-zA-Z]       -- alphabetic characters

-- second RE macros

@identifier = $alpha[$alpha $digit]* -- identifiers
@number     = $digit+


-- tokens declarations

tokens :-
      -- whitespace and comments 
      <0> $white+       ;
      <0> "//" .*       ;
      <0> "/*"          {nestComment `andBegin` state_comment}
      <0> "*/"          {\ _ _ -> alexError "Error! Unexpected close comment!"}
      <state_comment> "/*"                     {nestComment}
      <state_comment> "*/"                     {unnestComment}
      <state_comment> .                        ;  
      <state_comment> \n                       ;

      -- other tokens 

      <0> "Var"         {simpleToken TVar}
      <0> "Z"           {simpleToken TZero}
      <0> "S"           {simpleToken TSucc}
      <0> "Plus"        {simpleToken TPlus}
      <0> "Minus"       {simpleToken TMinus}
      <0> "Mult"        {simpleToken TMult}
      <0> "Max"         {simpleToken TMax}

      <0> "PropVar"     {simpleToken TPropVar}
      <0> "Not"         {simpleToken TNot}
      <0> "And"         {simpleToken TAnd}
      <0> "Or"          {simpleToken TOr}
      <0> "Imp"         {simpleToken TImp}
      
      <0> "Eq"          {simpleToken TEq}
      <0> "Lt"          {simpleToken TLt}
      <0> "Gt"          {simpleToken TGt}
      <0> "Le"          {simpleToken TLe}
      <0> "Ge"          {simpleToken TGe}
      <0> "ForAll"      {simpleToken TForAll}
      <0> "Exists"      {simpleToken TExists}
      
      <0> "("           {simpleToken TLParen}
      <0> ")"           {simpleToken TRParen}
      
      <0> @number       {mkNumber}
      <0> @identifier   {mkIdent}

{

-- user state 

data AlexUserState 
  = AlexUserState {
      nestLevel :: Int 
    }

alexInitUserState :: AlexUserState 
alexInitUserState 
  = AlexUserState 0 

get :: Alex AlexUserState
get = Alex $ \s -> Right (s, alex_ust s)

put :: AlexUserState -> Alex ()
put s' = Alex $ \s -> Right (s{alex_ust = s'}, ())

modify :: (AlexUserState -> AlexUserState) -> Alex ()
modify f 
  = Alex $ \s -> Right (s{alex_ust = f (alex_ust s)}, ())

alexEOF :: Alex Token
alexEOF = do
  (pos, _, _, _) <- alexGetInput
  startCode <- alexGetStartCode
  when (startCode == state_comment) $
    alexError "Error: unclosed comment"
  pure $ Token (position pos) TEOF

-- token definition

data Token
  = Token {
      pos :: (Int, Int)
    , lexeme :: Lexeme 
    } deriving (Eq, Ord, Show)

data Lexeme
  = TVar
  | TZero
  | TSucc
  | TPlus
  | TMinus
  | TMult
  | TMax

  | TPropVar
  | TNot
  | TAnd
  | TOr
  | TImp
  | TEq
  | TLt
  | TGt
  | TLe
  | TGe
  | TForAll
  | TExists

  | TLParen
  | TRParen
  | TEOF

  | TIdent Vars
  | TNumber Int
  deriving (Eq, Ord, Show)

position :: AlexPosn -> (Int, Int)
position (AlexPn _ x y) = (x,y)

mkIdent :: AlexAction Token 
mkIdent (st, _, _, str) len = do
  let s = take len str
  case readMaybe s of
    Just v  -> pure $ Token (position st) (TIdent v)
    Nothing -> alexError $ "Lexer Errpr: Variable '" ++ s ++ "' not allowed."

mkNumber :: AlexAction Token
mkNumber (st, _, _, str) len 
  = pure $ Token (position st) (TNumber $ read $ take len str)


simpleToken :: Lexeme -> AlexAction Token
simpleToken lx (st, _, _, _) _
  = return $ Token (position st) lx

-- dealing with comments

nestComment :: AlexAction Token
nestComment input len = do
  modify $ \s -> s{nestLevel = nestLevel s + 1}
  skip input len

unnestComment :: AlexAction Token 
unnestComment input len 
  = do
      s <- get
      let level = (nestLevel s) - 1
      put s{nestLevel = level}
      when (level == 0) $
        alexSetStartCode 0
      skip input len


lexer :: String -> Either String [Token]
lexer s = runAlex s go 
  where 
    go = do 
      output <- alexMonadScan 
      if lexeme output == TEOF then 
        pure [output]
      else (output :) <$> go
}