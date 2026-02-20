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
$string_char = [^\"\\\n]

-- second RE macros

@identifier = $alpha[$alpha $digit]* -- identifiers
@number     = $digit+
@string     = \"($string_char)*\"  -- string literals

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

      -- string literals
      <0> @string       { mkString }

      -- other tokens 

      <0> "+"           {simpleToken TPlus}
      <0> "-"           {simpleToken TMinus}
      <0> "*"           {simpleToken TMult}
      
      <0> "not"         {simpleToken TNot}
      <0> "and"         {simpleToken TAnd}
      <0> "or"          {simpleToken TOr}
      <0> "implies"     {simpleToken TImp}
      
      <0> "=="          {simpleToken TEq}
      <0> ">"           {simpleToken TGt}
      <0> ">="          {simpleToken TGe}
      <0> "<"           {simpleToken TLt}
      <0> "<="          {simpleToken TLe}
      <0> "exists"      {simpleToken TExists}
      <0> "forall"      {simpleToken TForAll}

      <0> "skip"        {simpleToken TSkip}
      <0> "="           {simpleToken TAssign}
      <0> "if"          {simpleToken TIf}
      <0> "then"        {simpleToken TThen}
      <0> "else"        {simpleToken TElse}
      <0> "while"       {simpleToken TWhile}
      <0> "do"          {simpleToken TDo}
      <0> "end"         {simpleToken TEnd}
      
      <0> "{"           {simpleToken TLBracket}
      <0> "}"           {simpleToken TRBracket}
      <0> "("           {simpleToken TLParen}
      <0> ")"           {simpleToken TRParen}
      <0> "|"           {simpleToken TBar}
      <0> "."           {simpleToken TDot}
      <0> ";"           {simpleToken TSemicolons}
      
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
  = TPlus
  | TZero
  | TMinus
  | TMult
  
  | TNot
  | TAnd
  | TOr
  | TImp

  | TEq
  | TGt
  | TGe
  | TLt
  | TLe
  | TExists
  | TForAll

  | TSkip
  | TAssign
  | TIf
  | TThen
  | TElse
  | TWhile
  | TDo
  | TEnd

  | TLBracket
  | TRBracket
  | TLParen
  | TRParen
  | TBar
  | TDot
  | TSemicolons
  
  | TString String
  | TEOF

  | TIdent Vars
  | TNumber Int
  deriving (Eq, Ord, Show)

position :: AlexPosn -> (Int, Int)
position (AlexPn _ x y) = (x,y)

mkString :: AlexAction Token
mkString (st, _, _, str) len = do
  let s = take len str
  let content = init (tail s)
  let processed = processEscapes content
  pure $ Token (position st) (TString processed)
  where
    processEscapes [] = []
    processEscapes ('\\':'n':xs) = '\n' : processEscapes xs
    processEscapes ('\\':'r':xs) = '\r' : processEscapes xs
    processEscapes ('\\':'t':xs) = '\t' : processEscapes xs
    processEscapes ('\\':'\\':xs) = '\\' : processEscapes xs
    processEscapes ('\\':'\"':xs) = '\"' : processEscapes xs
    processEscapes (x:xs) = x : processEscapes xs

mkIdent :: AlexAction Token 
mkIdent (st, _, _, str) len = do
  let s = take len str
  case readMaybe s of
    Just v  -> pure $ Token (position st) (TIdent v)
    Nothing -> alexError $ "Lexer Error: Variable '" ++ s ++ "' not allowed."

mkNumber :: AlexAction Token
mkNumber (st, _, _, str) len 
  = pure $ Token (position st) (TNumber $ read $ take len str)

simpleToken :: Lexeme -> AlexAction Token
simpleToken lx (st, _, _, _) _
  = return $ Token (position st) lx

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