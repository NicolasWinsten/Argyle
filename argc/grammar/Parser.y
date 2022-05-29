{
-- TODO go to the lexer and add tokens for rightBindingOperators that end with a :
-- i'd rather just have this simpler rule than doing infixity declarations everywhere

module Parser(parse) where

import Token
}

%name parse
%tokentype { TokenClass }
%error { parseError }

%token
    VAR     { Tident $$ }
    OP      { Toperator $$ }
    CLASS   { Tkeyword "class" }
    DATA    { Tkeyword "data" }
    TYPE    { Tkeyword "type" }
    INSTANCE { Tkeyword "instance" }
    VIEW    { Tkeyword "view" }
    '|'    { Tpipe }
    ':'   { Tcolon }
    '='  { Tequals }
    '->'  { Trarrow }
    '<-'   { Tlarrow }
    '=>' { Tfatrarrow }
    ')'  { Trparen }
    '('   { Tlparen }
    '}'  { Trcurly }
    '{'   { Tlcurly }
    ']' { Trbracket }
    '['  { Tlbracket }
    ','   { Tcomma }
    ';'   { Tsemicolon }
    '_'     { Tunderscore }
    INDENT  { Tindent }
    DEDENT  { Tdedent }
    NEWLINE { Tnewline }
    INT     { TintLiteral $$ }
    CHAR    { TcharLiteral $$ }
    STRING  { TstringLiteral $$ }
    FLOAT   { TfloatLiteral $$ }

%%

prog    : body {reverse $1}

body    : prog decl {$2 : $1} | decl {[$1]}

indentedBody : INDENT body DEDENT {reverse $2} | {- empty -} {[]}

decl    : def {$1} | typesig {$1} | instance {$1} | class {$1} | adt {$1} | gadt {$1}

def     : VAR exprlist '=' rhs  { Def $1 (foldr Lambda $4 $ reverse $2) }
        | VAR '=' rhs  { Def $1 $3 }
        | single OP single '=' rhs { Def $2 $ Lambda $1 (Lambda $3 $5) }

rhs     : expr NEWLINE {$1} | NEWLINE INDENT expr NEWLINE DEDENT {$3}

exprlist    : single {[$1]} | exprlist single {$2 : $1}

expr   : lambda    { $1 }

lambda : singlelambda {$1}

singlelambda : oper '=>' expr {Lambda $1 $3} | oper { $1 }

oper    :  oper OP app {App (App (Ident $2) $1) $3} | app { $1 }

app     : single   {$1} | app single {App $1 $2}

single  : '(' expr ')'  {$2}
        | '(' OP ')'    { Ident $2 }
        | VAR           { Ident $1 }
        | INT           { LiteralInt $1 }
        | CHAR          { LiteralChar $1 }
        | STRING        { LiteralString $1 }
        | FLOAT         { LiteralFloat $1 }
        | '_'           { UnderScore }


varlistAux  : {- empty -} {[]} | varlistAux VAR {$2 : $1} | VAR {[$1]}
varlist     : varlistAux {reverse $1}

typesig : VAR typeannotation NEWLINE { TypeSig $1 $2 }

typeannotation  : ':' constrainedtype {$2}

-- a type followed by zero or more constraints as in Functor f => f a
constrainedtype : constraintlist '=>' type {Constrained (reverse $1) $3} | type {Constrained [] $1}
constraintlist  : constraintlist ',' constraint {$3 : $1} | constraint {[$1]}
constraint      : VAR varlist {Constraint $1 $2} 

type    : type1 '->' type { TyCon "->" [$1, $3] } | type1 {$1}
type1   : typelist { fromTypeList $1 }
typelistAux: typelistAux singletype {$2 : $1} | singletype {[$1]}
typelist: typelistAux {reverse $1}
singletype  : '(' type ')' {$2} | VAR {Ty $1} | '(' ')' {Ty "Unit"}

-- constructor: Instance [Constraint] String String [Type] [Decl]
-- constraints, implementation name, class name, arguments, body implementations
instance    : INSTANCE constrainedtype NEWLINE indentedBody {mkInstance $2 $4}

class       : CLASS constrainedtype NEWLINE indentedBody {mkClass $2 $4}

-- algebraic data type definition
adt         : DATA VAR varlist adtrhs {ADT $2 $3 $4}
adtrhs      : '=' constructors NEWLINE {reverse $2}
            | NEWLINE INDENT '=' variant NEWLINE linedconstructors DEDENT {$4 : reverse $6}
            | NEWLINE INDENT '=' constructors NEWLINE DEDENT {reverse $4}
constructors: constructors '|' variant {$3 : $1} | variant {[$1]}
linedconstructors: {- empty -} {[]} | '|' variant NEWLINE {[$2]}
                | linedconstructors '|' variant NEWLINE {$3 : $1}
variant     : VAR typelist {($1, $2)} | VAR {($1, [])}

-- generalized algebraic datatype
gadt                : DATA VAR varlist NEWLINE INDENT gadtconstructor gadtconstructors { GADT $2 $3 ($6 : reverse $7) }
gadtconstructors    : DEDENT {[]} | gadtconstructor gadtconstructors {$1 : $2}
gadtconstructor     : VAR typeannotation NEWLINE {($1, $2)}
{

parseError :: [TokenClass] -> a
parseError toks = error $ "Parse Error:" ++ show toks

data Expr
    = Lambda Expr Expr
    | App Expr Expr
    | Ident String
    | LiteralInt Int
    | LiteralFloat Float
    | LiteralString String
    | LiteralChar Char
    | UnderScore
    deriving Show

data Constraint = Constraint String [String] deriving (Show, Eq)

data Type
    = Ty String
    | TyCon String [Type]
    deriving (Show, Eq)

data ConstrainedType = Constrained [Constraint] Type deriving (Show, Eq)

-- declarations/definitions for type signatures, functions, datatypes, type functions, classes, instances, views
data Decl
    = Def String Expr
    | TypeSig String ConstrainedType
    | ADT String [String] [(String, [Type])] -- kind name, parameters, mappings of constructor names to their types
    | GADT String [String] [(String, ConstrainedType)]
    | TypeFun String [String] Type  -- function name, parameters, body
    | Class [Constraint] String [String] [Decl]  -- type constraints, class name, parameters, method declarations / default implementations
    | Instance [Constraint] String String [Type] [Decl]  -- type constraints, implementation name, class name, arguments, method implementations
    | View [Constraint] [Type] Type [(String, [Type])] Expr -- type constraints, parameters, type, pattern names mapped to their fruit, conversion function
    deriving Show


-- given a type signature Either a b, it is parsed as [Ty "Either", Ty "a", Ty "b"]
-- this function converts it to TyCon "Either" [Ty "a", Ty "b"]
fromTypeList :: [Type] -> Type
fromTypeList [ty] = ty
fromTypeList (Ty a : tys) = TyCon a tys
fromTypeList (TyCon name tys : others) = TyCon name (tys ++ others)

isSimple :: Type -> Bool
isSimple (Ty _) = True
isSimple _ = False

kindName :: Type -> String
kindName (Ty a) = a
kindName (TyCon a _) = a

-- i'm reusing the constrainedtype rule to parse class and instance declarations
-- so I use these weird functions to create them from ConstrainedType parses

mkInstance :: ConstrainedType -> [Decl] -> Decl
mkInstance (Constrained consts ty) decls =
    case ty of
        Ty a -> Instance consts "" a [] decls
        TyCon a tys -> Instance consts "" a tys decls

mkClass :: ConstrainedType -> [Decl] -> Decl
mkClass (Constrained consts ty) decls =
    case ty of
        Ty a -> Class consts a [] decls
        TyCon a tys | all isSimple tys -> Class consts a (map kindName tys) decls
        ty -> error $ "Your class declaration for " ++ kindName ty ++ " is funky."
}