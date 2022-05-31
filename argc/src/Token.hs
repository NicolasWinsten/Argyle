module Token where

import qualified Data.Map as Map
import qualified Data.Set as Set

data TokenClass
    = Tident String     -- identifier
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
    | Tunderscore   -- _
--    | Thash         -- #
    | Tindent       -- indentation marker
    | Tdedent       -- indentation done marker
    | Tnewline      -- newline
    | TintLiteral Int
    | TcharLiteral Char
    | TstringLiteral String
    | TfloatLiteral Float
    deriving (Show, Eq)

data Location = Loc {line :: Int, col :: Int}
data Token = Token {tokenClass :: TokenClass, loc :: Location}

instance Show Token where
    show = show . tokenClass

keywords = ["class", "data", "type", "instance", "view", "do", "else"]

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
        , ("_", Tunderscore)
        ]

validOperatorSymbols = Set.fromList "~!@#$%^&*-+=|:?/<>."


