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
    OPR     { Troperator $$}
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

body    : body decl {$2 : $1} | decl {[$1]}

indentedBody : INDENT body DEDENT {reverse $2} | {- empty -} {[]}

decl    : def {$1} | typesig {$1} | instance {$1} | class {$1} | data {$1}

def     : VAR exprlist '=' rhs  { Def $1 (foldr lambda $4 $2) }
        | VAR '=' rhs  { Def $1 $3 }
        | single OP single '=' rhs { Def $2 $ lambda $1 (lambda $3 $5) }

rhs     : expr NEWLINE {$1} | NEWLINE INDENT expr NEWLINE DEDENT {$3}

exprlistAux : single {[$1]} | exprlistAux single {$2 : $1}
exprlist    : exprlistAux {reverse $1}

expr   : lambda    { $1 }

lambda : singlelambda {$1}

maybeLambda : exprlist lamrhs
lamrhs  : '=>' expr {$2} | {- empty -} {}

singlelambda : exprlist '=>' expr {Lambda [($1, $3)]}

-- right-associative operations
rightoper: oper OPR rightoper {App (App (Ident $2) $1) $3} | oper {$1}

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


varlistAux  :  varlistAux VAR {$2 : $1} | VAR {[$1]}
varlist     : varlistAux {reverse $1}

typesig : VAR typeannotation NEWLINE { TypeSig $1 $2 } | '(' OP ')' typeannotation NEWLINE { TypeSig $2 $4 }

typeannotation  : ':' constrainedtype {$2}

-- a type followed by zero or more constraints as in Functor f => f a
constraintlist  : constraint ',' constraintlist {$1 : $3} | constraint {[$1]}
constraint      : varlist { Constraint (head $1) (tail $1)}
-- context         : constraintlist '=>' {$1}

-- this funky rule is to avoid the reduce/reduce conflict that comes with a rule like:
-- constrainedtype : constraintlist '=>' type | type
-- a constraint looks the exact same as a simple type: Show a ~ Maybe a
-- so we first just attempt to parse a type, and then if we see that it is on the left-hand side of the '=>'
-- we convert it to a constraint
constrainedtype : type                              {Constrained [] $1} -- case of type with no context
                | type ',' constraintlist '=>' type {Constrained (ty2constraint $1 : $3) $5} -- case of multiple constraints in the context
                | type '=>' type                    {Constrained [ty2constraint $1] $3} -- one constraint

type    : ftype {$1} 
-- function type
ftype   : typeopr '->' ftype { TyCon "->" [$1, $3] } | typeopr {$1}
-- right associative type operator
typeopr : typeop OPR typeopr { TyCon $2 [$1, $3]} | typeop {$1}
-- left associative type operator
typeop  : typeop OP typeapp {TyCon $2 [$1, $3]} | typeapp {$1}

typeapp : typelist { fromTypeList $1 }
typelistAux: typelistAux singletype {$2 : $1} | singletype {[$1]}
typelist: typelistAux {reverse $1}
singletype  : '(' type ')' {$2} | VAR {Ty $1} | '(' ')' {Ty "Unit"}

-- constructor: Instance [Constraint] String String [Type] [Decl]
-- constraints, implementation name, class name, arguments, body implementations
instance    : INSTANCE constrainedtype NEWLINE indentedBody {mkInstance $2 $4}

class       : CLASS constrainedtype NEWLINE indentedBody {mkClass $2 $4}


data        : DATA varlist datarhs {$3 (head $2) (tail $2)}

datarhs     : '=' constructorsS {\name tvars -> ADT name tvars (reverse $2)}
            | NEWLINE INDENT '=' constructorsS DEDENT {\name tvars -> ADT name tvars (reverse $4)}
            | NEWLINE INDENT gadtconstructors DEDENT {\name tvars -> GADT name tvars (reverse $3)}

-- algebraic data type constructors
-- there's gotta be a better way to do this one
constructorsS   : NEWLINE INDENT constructorsB NEWLINE '|' constructorsS DEDENT {$3 ++ $6}
                | NEWLINE INDENT constructorsB NEWLINE INDENT '|' constructorsS DEDENT DEDENT {$3 ++ $7}
                | NEWLINE INDENT constructorsB NEWLINE DEDENT {$3}
                | constructorsB NEWLINE INDENT '|' constructorsS DEDENT {$1 ++ $5}
                | constructorsB NEWLINE '|' constructorsS {$1 ++ $4}
                | constructorsB NEWLINE {$1}
-- single line of constructors
constructorsB   : constructorsB '|' variant {$3 : $1} | variant {[$1]}

variant         : VAR typelist {($1, $2)} | VAR {($1, [])}

-- generalized algebraic datatype constructors
gadtconstructors    : gadtconstructor {[$1]} | gadtconstructors gadtconstructor {$2 : $1}
gadtconstructor     : typesig {let (TypeSig name ty) = $1 in (name, ty)}
{

parseError :: [TokenClass] -> a
parseError toks = error $ "Parse Error:" ++ show toks

data Expr
    = Lambda [([Expr], Expr)]
    | App Expr Expr
    | Ident String
    | LiteralInt Int
    | LiteralFloat Float
    | LiteralString String
    | LiteralChar Char
    | UnderScore
    deriving Show

lambda :: Expr -> Expr -> Expr
lambda l r = Lambda [([l], r)]

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

ty2constraint :: Type -> Constraint
ty2constraint (Ty a) = Constraint a []
ty2constraint (TyCon a tys)
    | all isSimple tys = Constraint a (map kindName tys)
    | otherwise = error $ "Your type constraints are funky"




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