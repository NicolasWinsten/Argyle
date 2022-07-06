{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TypeFamilies #-}


module Lex(lexer) where

import ParseT

import Token
import Data.Char
import Data.List as List hiding (singleton)
import Data.Maybe
import Control.Monad
import Control.Applicative(Alternative((<|>), many, some))
import qualified Data.Map as Map
import Data.Tuple

(|||) :: (a -> Bool) -> (a -> Bool) -> a -> Bool
(|||) p q x = p x || q x

isSpaceOrTab :: Char -> Bool
isSpaceOrTab = flip elem [' ', '\t']

singleton = (: [])

data LexingState = LexState {
    charStream :: String, position :: Location, countingIndent :: Bool, indentChar :: Char, indentStack :: [Int]
} deriving Show

-- lexer will parse from a string while tracking location in the string
-- plus a flag that indicates if we should be counting indentation
-- (for after we've seen a newline and until we see a nonwhitespace character, we're counting indentation)
type Lexer a = ParseT LexingState a

instance ParseState LexingState where
    type El LexingState = Char
    getNext LexState{charStream=[]} = Nothing
    -- only update Location, the indent stack is handled by the indent/dedent parsers
    getNext (LexState (c:cs) pos countingIndent indentChar indentStack)
        = Just $ (,) c $ case c of
        '\n' -> LexState cs (incLine . resetCol . resetIndent $ pos) True indentChar indentStack
        c
            | countingIndent, c == badIndentChar -> error $ "You're mixing indentation first at line " ++ show (line pos)
            | countingIndent, c == indentChar -> LexState cs (incIndent . incCol $ pos) True indentChar indentStack
            | otherwise -> LexState cs (incCol pos) False indentChar indentStack
        where
            badIndentChar
              | indentChar == ' ' = '\t'
              | indentChar == '\t' = ' '
              | otherwise = error "Why are you indenting like a maniac?"

getPosition :: Lexer Location
getPosition = fmap position getState

lineNumber :: Lexer Int
lineNumber = fmap (line . position) getState

-- grab the size of the last indent
lastIndent :: Lexer Int
lastIndent = do
    stack <- fmap indentStack getState
    return $ fromMaybe 0 $ listToMaybe stack

-- NOTE: test for an emptyline before running this operation
updateIndentStack :: Lexer [TokenClass]
updateIndentStack = do
    ind <- eatWhitespace
    lastInd <- lastIndent
    currentStack <- indentStack <$> getState
    if ind > lastInd then do
        modifyState (\state -> state{indentStack= ind : currentStack})
        return [Tindent]
    else if ind == lastInd then
        return []
    else do
        modifyState (\state -> state{indentStack= dropWhile (> ind) currentStack})
        ind' <- lastIndent
        pos <- getPosition
        errorIf (ind' /= ind) "Orphaned indentation"
        let numDangling = length . takeWhile (> ind) $ currentStack
        return $ replicate numDangling Tdedent


emptyline :: Lexer ()
emptyline = do
    eatWhitespace
    newline >> pure () <|> end
    return ()

word :: Lexer String
word = do
    w <- chompWhile (not . isSpace)
    guard (not . null $ w)
    return w

keyword :: Lexer TokenClass
keyword = do
    w <- word
    guard (w `elem` keywords)
    return $ Tkeyword w

isValidIdent (c:cs) = isAlpha c && all (isAlphaNum ||| (`elem` "\'_")) cs
isValidIdent _ = False

identifier :: Lexer TokenClass
identifier = do
    w <- word
    guard (w `notElem` keywords)
    guard $ isValidIdent w
    return $ Tvar w

backtick = single '\''

infixIdentifier :: Lexer TokenClass
infixIdentifier = do
    backtick
    Tvar w <- identifier
    backtick
    return $ Toperator w

operator :: Lexer TokenClass
operator = do
    opName <- chompWhile (`elem` validOperatorSymbols)
    guard (not . null $ opName)
    guard $ not $ opName `Map.member` reservedSymbols
    return $ if last opName == ':' then Troperator opName else Toperator opName


-- eat a reserved non-alpha symbol like (, ), ->, =>, =, ;
-- some of the symbols have to be eaten eagerly.
-- For example, "(,)" parses out as '(' ',' ')' but =>> will parse as '=>>'
reservedSymbol :: Lexer TokenClass
reservedSymbol = fmap (reservedSymbols Map.!) (eagerSymbol <|> otherReservedSymbol)
    where
        symbols = concat $ Map.keys reservedSymbols
        eagerSymbol :: Lexer String
        eagerSymbol =
            fmap singleton . oneOf .
                map single $ filter (`notElem` validOperatorSymbols) symbols

        otherReservedSymbol :: Lexer String
        otherReservedSymbol = do
            sym <- oneOf $ map ParseT.seq $ Map.keys reservedSymbols
            guard (sym `Map.member` reservedSymbols)
            return sym

underscore :: Lexer TokenClass
underscore = do
    some $ single '_'
    c <- peek
    guard (not . isAlpha $ c)
    return Tunderscore

int :: Lexer TokenClass
int = do
    num <- chompWhile isDigit
    guard (not . null $ num)
    return $ TintLiteral . read $ num

float :: Lexer TokenClass
float = do
    TintLiteral whole <- int
    single '.'
    TintLiteral decimal <- int
    let num = show whole ++ "." ++ show decimal
    return $ TfloatLiteral . read $ num

-- TODO handle escaped characters!
char :: Lexer TokenClass
char = do
    single '\''
    c <- next
    single '\''
    return $ TcharLiteral c

string :: Lexer TokenClass
string = do
    single '\"'
    str <- chompWhile (/= '"')
    single '\"'
    return $ TstringLiteral str

newline :: Lexer TokenClass
newline = single '\n' >> pure Tnewline

eatWhitespace :: Lexer Int
eatWhitespace = length <$> chompWhile (`elem` "\t ")

token :: Lexer TokenClass
token = oneOf $ fmap (<* eatWhitespace)
    [ keyword
    , identifier
    , float
    , int
    , char
    , string
    , operator
    , reservedSymbol
    , underscore
    , infixIdentifier
    ]

-- parse a tokenclass and mark where it is in the source
enrichWithLocation :: Lexer TokenClass -> Lexer Token
enrichWithLocation p = do
    pos <- getPosition
    tok <- p
    return $ Token tok pos


lexer :: String -> [Token]
lexer input = result where
    -- determine if user is using tabs or spaces for indentation
    firstChars = mapMaybe listToMaybe $ lines input
    indentChar = fromMaybe '\t' $ find isSpaceOrTab firstChars

    initState = LexState
        input
        Loc{line=1, col=0, indentation=0}
        False
        indentChar
        []

    -- any indentation tokens
    indentation' :: Lexer [Token]
    indentation' = do
        pos <- getPosition
        map (`Token` pos) <$> updateIndentStack

    -- content tokens
    content :: Lexer [Token]
    content = many $ enrichWithLocation token

    -- a newline possibly followed by emptylines
    newline' :: Lexer [Token]
    newline' = singleton <$> enrichWithLocation (newline <* many emptyline)

    
    scan :: Lexer [Token]
    scan = do
        toks1 <- indentation'
        toks2 <- content
        maybeMore <- try newline'
        case maybeMore of
            Just toks3 -> do
                more <- scan
                return $ toks1 ++ toks2 ++ toks3 ++ more
            Nothing -> do
                pos <- getPosition
                cleanup <- indentation' -- close out dangling indentation blocks
                let maybeNewline = [Token Tnewline pos | not (null cleanup)]
                return $ toks1 ++ toks2 ++ maybeNewline ++ cleanup


    result = case run (newline' >> scan <* end) initState of
      Left err@(_, state) -> error $ showError input err (position state)
      Right (toks, _) -> toks
