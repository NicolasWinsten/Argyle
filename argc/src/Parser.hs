{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use <$>" #-}
{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE LambdaCase #-}
module Parser(parse) where

import ParseT
import ParserHelpers
import Lex
import Control.Applicative(Alternative(..))
import Data.Maybe
import Control.Monad
import Token

data Expr
  = Var String
  | App Expr Expr
  | Int Int
  | Float Float
  | Char Char
  | String String
  | Underscore
  | Lambda [([Expr], Expr)]
  | SectionL String Expr    -- (== x) ==> SectionL "==" (Var x)
  | SectionR Expr String    -- (x -)  ==> SectionR (Var x) "-"
  deriving Show

data Constraint = Constraint String [String] deriving (Show, Eq)

data ConstrainedType = ConstrTy [Constraint] Type deriving (Show, Eq)

data Type
  = Ty String
  | TyCon String [Type]
  deriving (Show, Eq)

data Decl
  = Def Expr Expr                   -- definition ( foo x y = ... )
  | TypeSig String ConstrainedType  -- type signature ( x : Int )
  | ADT                 -- algebraic data type definition
    String              -- data type name
    [String]            -- type parameters
    [(String, [Type])]  -- constructor variants
  deriving Show


someOp :: Parser String
someOp = oneOf [op, rop]

-- read a parsed expression as a type
mkTy :: Expr -> Type
mkTy (Var i) = Ty i
mkTy (App (Var i) outer) = TyCon i [mkTy outer]
mkTy (App (mkTy -> TyCon t args) right) = TyCon t (args ++ [mkTy right])
mkTy t = error $ "I don't know how to make type from: " ++ show t

-- parse a type with a context
ty :: Parser Type
ty =
  oneOf [do {argTy <- ty1; rarrow; resTy <- ty; return $ TyCon "->" [argTy, resTy]}, ty1]
  where ty1 = fmap mkTy rightOperation -- parse types as expressions and convert them

-- parse a list of constraints from a given context
-- Logger, Show b, Convertable a b => ...
context :: Parser [Constraint]
context = maybeWith parend constraintlist <* fatrarrow
  where
    constraint = do
      clazz <- var
      tys <- many var
      return $ Constraint clazz tys

    constraintlist = listOf comma constraint

-- parse a type that might have a context: Show a => a
constrainedty :: Parser ConstrainedType
constrainedty = do
  ctx <- context
  theType <- ty
  return $ ConstrTy ctx theType

-- parse a type signature: map : Functor f => (a -> b) -> f a -> f b
typesig :: Parser Decl
typesig = do
  name <- oneOf [var, parend someOp]
  colon
  type' <- constrainedty
  return $ TypeSig name type'


def :: Parser Decl
def = do
  lhs <- expr
  eq
  rhs <- maybeWith indented expr
  newline
  return $ Def lhs rhs

-- parse an algebraic datatype: data Maybe a = Just a | Nothing
adt :: Parser Decl
adt = do
  keyword "data"
  name <- var
  tyvars <- many var
  variants <- rhs
  return $ ADT name tyvars variants
  where
    unwrap = \case
      TyCon n args -> Ty n : args
      t -> [t]

    variant = do
      varname <- oneOf [var, parend op, parend rop]
      tys <- fmap (fromMaybe []) . try $ fmap unwrap ty
      return (varname, tys)
    
    lineofvariants :: Parser [(String, [Type])]
    lineofvariants = nonEmptyListOf pipe variant
    -- multiple lines of variants, each line starting with a pipe
    multilinesofvariants :: Parser [(String, [Type])]
    multilinesofvariants = fmap concat $ nonEmptyListOf newline (pipe >> lineofvariants)

    -- i would also like to support a constructor with indented list of parameters:
    -- ELet
    --  IsRec
    --  [(a, Expr a)]
    --  (Expr a)

    -- single line rhs
    rhs = undefined
    


decl :: Parser Decl
decl = oneOf [def, typesig, adt]

expr :: Parser Expr
expr = oneOf [lambda, rightOperation]

-- parse one case of a lambda
-- Nothing j -> j parses as ([Var Nothing, Var j], Var j)
singleLambda :: Parser ([Expr], Expr)
singleLambda = do
  pats <- some bottomExpr
  rarrow
  e <- expr
  return (pats, e)

-- lambda cases separated by semicolons
sameLineLambda :: Parser Expr
sameLineLambda = fmap Lambda $ nonEmptyListOf semicolon singleLambda

-- lambda cases separated by newlines (must also be indented)
-- this "lambda block" must be introduced by a newline and indentation
multiLineLambda :: Parser Expr
multiLineLambda = fmap Lambda $ nonEmptyListOf newline singleLambda

lambda :: Parser Expr
lambda = oneOf [sameLineLambda, multiLineLambda]

-- right associative operations
rightOperation :: Parser Expr
rightOperation =
  oneOf
  [ do left <- operation; opName <- rop; right <- rightOperation; return $ App (App (Var opName) left) right
  , operation
  ]

-- left associative operations, is complicated because we are avoiding left recursion
operation :: Parser Expr
operation = do { first <- app; right <- operation'; pure $ foldl apply first right} where
  operation' =
    oneOf [do opName <- op; rhs <- app; more <- operation'; pure $ (opName, rhs) : more, pure []]
  apply left (opName, rhs) = App (App (Var opName) left) rhs

-- application (expr) (expr)
app :: Parser Expr
app = fmap (foldl1 App) (some bottomExpr)

bottomExpr :: Parser Expr
bottomExpr =
  oneOf
  [ fmap Var var
  , fmap Int intLit
  , fmap Float floatLit
  , fmap Char charLit
  , fmap String stringLit
  , underscore >> return Underscore
  , parend $ Var <$> someOp         -- (+)
  , sectionL                        -- (+ 2)
  , sectionR                        -- (2 +)
  , parend expr                     -- (expr)
  ]
  where
    sectionL = parend $ liftM2 SectionL someOp expr
    sectionR = parend $ liftM2 SectionR expr someOp

parse :: String -> Decl
parse input = case run def (lexer input, Loc 1 0 0) of
  Right (x, _) -> x
  Left err@(_, (_, location)) -> error $ showError input err location
