{
module Parser.PropCalc (propCalcParser) where

import Lexer.Lexer hiding (lexer)
import Syntax
import Variables
}

%name parser Prop
%monad {Alex}{(>>=)}{return}
%tokentype { Token }
%error { parseError }
%lexer {lexer}{Token _ TEOF}

%token
    id          { Token _ (TIdent $$) }

    'Var'       { Token _ TVar }
    'Z'         { Token _ TZero }
    'S'         { Token _ TSucc }
    'Plus'      { Token _ TPlus }
    'Minus'     { Token _ TMinus }
    'Mult'      { Token _ TMult }
    'Max'       { Token _ TMax }

    'PropVar'   { Token _ TPropVar }
    'Not'       { Token _ TNot }
    'And'       { Token _ TAnd }
    'Or'        { Token _ TOr }
    'Imp'       { Token _ TImp }

    'Eq'        { Token _ TEq }
    'Lt'        { Token _ TLt }
    'Gt'        { Token _ TGt }
    'Le'        { Token _ TLe }
    'Ge'        { Token _ TGe }
    'ForAll'    { Token _ TForAll }
    'Exists'    { Token _ TExists }

    '('         { Token _ TLParen }
    ')'         { Token _ TRParen }

%%

Prop
    : 'PropVar' '(' FOLExpr ')'          { PropVar $3 }
    | 'Not' '(' Prop ')'                 { Not $3 }
    | 'And' '(' Prop ')' '(' Prop ')'    { And $3 $6 }
    | 'Or' '(' Prop ')' '(' Prop ')'     { Or $3 $6 }
    | 'Imp' '(' Prop ')' '(' Prop ')'    { Imp $3 $6 }
    | '(' Prop ')'                       { $2 }

FOLExpr
    : 'Eq' '(' Exp ')' '(' Exp ')'       { Eq $3 $6 }
    | 'Lt' '(' Exp ')' '(' Exp ')'       { Lt $3 $6 }
    | 'Gt' '(' Exp ')' '(' Exp ')'       { Gt $3 $6 }
    | 'Le' '(' Exp ')' '(' Exp ')'       { Le $3 $6 }
    | 'Ge' '(' Exp ')' '(' Exp ')'       { Ge $3 $6 }
    | 'ForAll' id '(' Prop ')'           { ForAll $2 $4 }
    | 'Exists' id '(' Prop ')'           { Exists $2 $4 }

Exp
    : 'Var' id                           { Var $2 }
    | 'Z'                                { Z }
    | 'S' Exp                            { S $2 }
    | 'Plus' '(' Exp ')' '(' Exp ')'     { Plus $3 $6 }
    | 'Minus' '(' Exp ')' '(' Exp ')'    { Minus $3 $6 }
    | 'Mult' '(' Exp ')' '(' Exp ')'     { Mult $3 $6 }
    | 'Max' '(' Exp ')' '(' Exp ')'      { Max $3 $6 }
    | '(' Exp ')'                        { $2 }

{
parseError :: Token -> Alex a
parseError (Token (l,c) lex)
  = alexError $
      "Parse error at line " ++ show l ++
      ", column " ++ show c ++
      "\nUnexpected token: " ++ show lex

lexer :: (Token -> Alex a) -> Alex a
lexer = (=<< alexMonadScan)

propCalcParser :: String -> Either String (PropCalc (FOL Vars))
propCalcParser input =
  runAlex input parser
}
