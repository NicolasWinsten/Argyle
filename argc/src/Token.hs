{-# LANGUAGE LambdaCase #-}
module Token where

import qualified Data.Map as Map
import qualified Data.Set as Set
import Data.Char (isAlpha)
import Text.Printf (printf)

data TokenClass
    = Tvar String     -- identifier
    | Toperator String  -- infix operator
    | Troperator String -- right associative infix operator
    | Tkeyword String   -- class, instance, view, alias, data
    | Tpipe         -- |
    | Tcolon        -- :
    | Tequals       -- =
    | Trarrow       -- ->
    | Tlarrow       -- <-
    | Tfatrarrow    -- =>
--    | Tfatlarrow    -- <=
    | Trparen       -- )
    | Tlparen       -- (
    | Trcurly       -- }
    | Tlcurly       -- {
    | Trbracket     -- ]
    | Tlbracket     -- [
    | Tcomma        -- ,
    | Tsemicolon    -- ;
--    | Thash         -- #
    | Tindent       -- indentation marker
    | Tdedent       -- indentation done marker
    | Tnewline      -- newline
    | TintLiteral Int
    | TcharLiteral Char
    | TstringLiteral String
    | TfloatLiteral Float
    | Tunderscore
    | TEOF
    deriving (Show, Eq)


-- Location in source code (col includes indentation tabs/spaces)
data Location = Loc {line :: Int, col :: Int, indentation :: Int}
incLine loc = loc{line=line loc + 1}
incCol loc = loc{col=col loc + 1}
incIndent loc = loc{indentation=indentation loc + 1}
resetCol loc = loc{col=0}
resetIndent loc = loc{indentation=0}

instance Show Location where
    show (Loc line col indentation) = printf "%s,%s:%s" (show line) (show col) (show indentation)

data Token = Token {tokenClass :: TokenClass, loc :: Location}

instance Show Token where
    show (Token tok pos) = printf "%s[%s]" (show tok) (show pos)


keywords = ["class", "data", "type", "instance", "view", "do", "else", "()"]

-- non-alpha symbols we care about
reservedSymbols = Map.fromList items where
    items =
        [ ("|", Tpipe)
        , (":", Tcolon)
        , ("=", Tequals)
        , ("->", Trarrow)
        , ("<-", Tlarrow)
        , ("=>", Tfatrarrow)
--        , ("<=", Tfatlarrow)
        , ("(", Tlparen)
        , (")", Trparen)
        , ("{", Tlcurly)
        , ("}", Trcurly)
        , ("[", Tlbracket)
        , ("]", Trbracket)
        , (",", Tcomma)
        , (";", Tsemicolon)
        ]

validOperatorSymbols = Set.fromList "~!@#$%^&*-+=|:?/<>."


tokLength :: TokenClass -> Int
tokLength = \case
  Tvar s -> length s
  Toperator s -> length s + if isAlpha $ head s then 2 else 0 -- account for infix identifiers that have backticks
  Troperator s -> length s
  Tkeyword s -> length s
  Tpipe -> 1
  Tcolon -> 1
  Tequals -> 1
  Trarrow -> 2
  Tlarrow -> 2
  Tfatrarrow -> 2
  Trparen -> 1
  Tlparen -> 1
  Trcurly -> 1
  Tlcurly -> 1
  Trbracket -> 1
  Tlbracket -> 1
  Tcomma -> 1
  Tunderscore -> 1
  Tsemicolon -> 1
  TintLiteral n -> length . show $ n
  TcharLiteral c -> 3
  TstringLiteral s -> length s + 2
  TfloatLiteral x -> length . show $ x
  _ -> 0
    