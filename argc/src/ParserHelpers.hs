{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}
module ParserHelpers where

import ParseT
import Token
import Data.Maybe

type ParsingState = ([Token], Location)

type Parser a = ParseT ParsingState a

instance ParseState ParsingState where
  type El ParsingState = TokenClass
  getNext ([], _) = Nothing
  getNext (tok:tok2:toks, _) = Just (tokenClass tok, (tok2:toks, loc tok2))
  getNext ([tok], location) | t <- tokenClass tok = Just (t, ([], iterate incCol location !! tokLength t))

getPosition :: Parser Location
getPosition = snd <$> getState

getIndentation :: Parser Int
getIndentation = fmap indentation getPosition

var :: Parser String
var = attempt $ \case
  Tvar i -> Just i
  _ -> Nothing

op :: Parser String
op = attempt $ \case
  Toperator i -> Just i
  _ -> Nothing

rop :: Parser String
rop = attempt $ \case
  Troperator i -> Just i
  _ -> Nothing

keyword :: String -> Parser TokenClass
keyword word = satisfy (== Tkeyword word)

pipe :: Parser TokenClass
pipe = satisfy (== Tpipe)

colon :: Parser TokenClass
colon = satisfy (== Tcolon)

eq :: Parser TokenClass
eq = satisfy (== Tequals)

rarrow :: Parser TokenClass
rarrow = satisfy (== Trarrow)

larrow :: Parser TokenClass
larrow = satisfy (== Tlarrow)

fatrarrow :: Parser TokenClass
fatrarrow = satisfy (== Tfatrarrow)

rparen :: Parser TokenClass
rparen = satisfy (== Trparen)

lparen :: Parser TokenClass
lparen = satisfy (== Tlparen)

rcurly :: Parser TokenClass
rcurly = satisfy (== Trcurly)

lcurly :: Parser TokenClass
lcurly = satisfy (== Tlcurly)

rbracket :: Parser TokenClass
rbracket = satisfy (== Trbracket)

lbracket :: Parser TokenClass
lbracket = satisfy (== Tlbracket)

comma :: Parser TokenClass
comma = satisfy (== Tcomma)

semicolon :: Parser TokenClass
semicolon = satisfy (== Tsemicolon)

underscore :: Parser TokenClass
underscore = satisfy (== Tunderscore)

indent :: Parser TokenClass
indent = satisfy (== Tindent)

dedent :: Parser TokenClass
dedent = satisfy (== Tdedent)

newline :: Parser TokenClass
newline = satisfy (== Tnewline)

intLit :: Parser Int
intLit = attempt $ \case
  (TintLiteral i) -> Just i
  _ -> Nothing


charLit :: Parser Char
charLit = attempt $ \case
  (TcharLiteral c) -> Just c
  _ -> Nothing


stringLit :: Parser String
stringLit = attempt $ \case
  (TstringLiteral str) -> Just str
  _ -> Nothing

floatLit :: Parser Float
floatLit = attempt $ \case
  (TfloatLiteral f) -> Just f
  _ -> Nothing

indented :: Parser a -> Parser a
indented = enclosed indent dedent

parend :: Parser a -> Parser a
parend = enclosed lparen rparen


eof :: Parser ()
eof = satisfy (== TEOF) >> pure ()