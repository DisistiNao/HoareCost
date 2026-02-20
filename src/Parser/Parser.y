{
module Parser.Parser (hcParser, arithParser, propCalcParser, HCLang(..)) where

import Lexer.Lexer hiding (lexer)
import Syntax
import Utils (num)
import Variables
}

%name parser Prog
%name parseArith Exp
%name parsePropCalc Prop
%monad {Alex}{(>>=)}{return}
%tokentype { Token }
%error { parseError }
%lexer { lexer } { Token _ TEOF }

%token
    id            { Token _ (TIdent $$) }
    number        { Token _ (TNumber $$) }
    string        { Token _ (TString $$) }

    '+'           { Token _ TPlus }
    '-'           { Token _ TMinus }
    '*'           { Token _ TMult }
    
    'not'         { Token _ TNot }
    'and'         { Token _ TAnd }
    'or'          { Token _ TOr }
    'implies'     { Token _ TImp }
    
    '=='          { Token _ TEq }
    '>'           { Token _ TGt }
    '>='          { Token _ TGe }
    '<'           { Token _ TLt }
    '<='          { Token _ TLe }
    'exists'      { Token _ TExists }
    'forall'      { Token _ TForAll }

    'skip'        { Token _ TSkip }
    '='           { Token _ TAssign }
    'if'          { Token _ TIf }
    'then'        { Token _ TThen }
    'else'        { Token _ TElse }
    'while'       { Token _ TWhile }
    'do'          { Token _ TDo }
    'end'         { Token _ TEnd }
    
    '{'           { Token _ TLBracket }
    '}'           { Token _ TRBracket }
    '('           { Token _ TLParen }
    ')'           { Token _ TRParen }
    '|'           { Token _ TBar }
    '.'           { Token _ TDot }
    ';'           { Token _ TSemicolons }

%left ';'
%left '+' '-'
%left '*'
%nonassoc '==' '>' '>=' '<' '<=' 

%%

Prog : '{' Prop '}' Cmd '{' Prop '|' Exp '}'        { HCLang $2 $4 $6 $8 }

Prop
    : '(' Prop ')'                                  { $2 }
    | 'not' Prop                                    { Not ($2) }
    | '(' Prop 'and' Prop ')'                       { And ($2) ($4) }
    | '(' Prop 'or' Prop ')'                        { Or ($2) ($4) }
    | 'implies' Prop Prop                           { Imp ($2) ($3) }
    | FOLExpr                                       { PropVar ($1) }

FOLExpr
    : Exp '==' Exp                                  { Eq ($1) ($3) }
    | Exp '<' Exp                                   { Lt ($1) ($3) }
    | Exp '<=' Exp                                  { Le ($1) ($3) }
    | Exp '>' Exp                                   { Gt ($1) ($3) }
    | Exp '>=' Exp                                  { Ge ($1) ($3) }
    | 'forall' id '.' '(' Prop ')'                  { ForAll ($2) ($5) }
    | 'exists' id '.' '(' Prop ')'                  { Exists ($2) ($5) }

Exp
    : '(' Exp ')'                                   { ($2) }
    | id                                            { Var ($1) }
    | number                                        { (num $1) }
    | Exp '+' Exp                                   { Plus ($1) ($3) }
    | Exp '-' Exp                                   { Minus ($1) ($3) }
    | Exp '*' Exp                                   { Mult ($1) ($3) }

Cmd 
    : 'skip'                                        { CSkip }
    | id '=' Exp                                    { CAssign ($1) ($3) }
    | 'if' Prop 'then' Cmd 'end' 'else' Cmd 'end'   { CIfElse ($2) ($4) ($7) }
    | 'while' string Prop 'do' Cmd 'end'            { CWhile ($2) ($3) ($5) }
    | Cmd ';' Cmd                                   { CSequence ($1) ($3) }

{
parseError (Token (line, col) lexeme)
  = alexError $ "Parse error while processing lexeme: " ++ show lexeme
                ++ "\n at line " ++ show line ++ ", column " ++ show col

data HCLang a = HCLang (PropCalc (FOL a)) (Command a) (PropCalc (FOL a)) (Arith a)

lexer :: (Token -> Alex a) -> Alex a
lexer = (=<< alexMonadScan)

hcParser :: String -> Either String (HCLang Vars)
hcParser input 
  = runAlex input parser 

arithParser :: String -> Either String (Arith Vars)
arithParser input = runAlex input parseArith

propCalcParser :: String -> Either String (PropCalc (FOL Vars))
propCalcParser input = runAlex input parsePropCalc
}