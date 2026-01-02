{
module Parser.Arith (arithParser) where

import Lexer.Lexer hiding (lexer)
import Syntax
}

-- %name parser Program
%name parser Exp
%monad {Alex}{(>>=)}{return}
%tokentype { Token }
%error { parseError }
%lexer {lexer}{Token _ TEOF}

%token
    id      { Token _ (TIdent $$) }
    num     { Token _ (TNumber $$) }

    'Var'   { Token _ TVar }
    'Z'     { Token _ TZero }
    'S'     { Token _ TSucc }
    'Plus'  { Token _ TPlus }
    'Mult'  { Token _ TMult }

    '('     { Token _ TLParen }
    ')'     { Token _ TRParen }
      
%%

-- Program : CodeBlock                       { Arith $1 }
--         | '(' Program ')'                 { Arith $2 }

-- CodeBlock : ExpList                       { reverse $1 }

-- ExpList : ExpList Exp                     { $2 : $1 }
--          |                                { [] }

Exp
    : 'Var' id                            { Var $2 }
    | 'Z'                                 { Z }
    | 'S' Exp                             { S $2 }
    | 'S' '(' Exp ')'                     { S $3 }
    | 'Plus' '(' Exp ')' '(' Exp ')'      { Plus $3 $6 }
    | 'Mult' '(' Exp ')' '(' Exp ')'      { Mult $3 $6 }
    | '(' Exp ')'                         { $2 }

{
parseError (Token (line, col) lexeme)
  = alexError $ "Parse error while processing lexeme: " ++ show lexeme
                ++ "\n at line " ++ show line ++ ", column " ++ show col

lexer :: (Token -> Alex a) -> Alex a
lexer = (=<< alexMonadScan)

arithParser :: String -> Either String (Arith String)
arithParser input 
  = runAlex input parser 
}