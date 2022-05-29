{-# LANGUAGE ViewPatterns #-}

module Lex(lexer) where

import Token
import Data.Char
import Data.List
import Data.Maybe
import Control.Monad
import qualified Data.Map as Map
import Data.Tuple

isSpaceOrTab :: Char -> Bool
isSpaceOrTab = flip elem [' ', '\t']

lastIndexOf :: Eq a => a -> [a] -> Maybe Int
lastIndexOf _ [] = Nothing
lastIndexOf x xs = helper x xs 0 where
    helper y (z:zs) idx
        | y == z = Just idx
        | otherwise = helper y zs (idx + 1)
    helper _ [] _ = Nothing

-- count the remaining elements in the list after the last occurrence of x
elemsAfter :: Eq a => a -> [a] -> Int
elemsAfter x xs
    | Just idx <- lastIndexOf x xs = length xs - 1 - idx
    | otherwise = 0

-- current input state means part of the input yet to be consumed and the current location
type InputState = (String, Location)

-- consumers will attempt to consume a token from the input
type Consumer = InputState -> Maybe (Token, InputState)

{-
eat p q will produce a consumer that will read chars until q is true
and check that the consumed string satisfies p
-}
eat :: (String -> Bool) -> (Char -> Bool) -> (String -> TokenClass) -> Consumer
eat p q tokClass = consume where
    consume :: Consumer
    consume (charStream, pos@Loc{line=line, col=col})
        | (word, rest) <- break q charStream
        , (not . null) word
        , p word
        , numNewlines <- length . filter (=='\n') $ word
        , newCol <- if numNewlines == 0 then col + length word else elemsAfter '\n' word
        = Just (Token (tokClass word) pos, (rest, pos{line = line + numNewlines, col = newCol}))
        | otherwise = Nothing

-- consume something from the input and discard it
chompThis :: String -> InputState -> Maybe InputState
chompThis thing (charStream, pos@Loc{line=line, col=col}) = do
    rest <- stripPrefix thing charStream
    let numNewlines = length . filter (== '\n') $ thing
    let newCol = if numNewlines == 0 then col + length thing else elemsAfter '\n' thing
    Just(rest, Loc{line=line+numNewlines, col=newCol})

eatKeyword :: Consumer
eatKeyword = eat (`elem` keywords) isSpace Tkeyword

eatIdentifier :: Consumer
eatIdentifier = eat isValidIdent (not. isAlphaNum) Tident
    where
        isValidIdent (c:cs) = isAlpha c && all isAlphaNum cs
        isValidIdent _ = False

-- scan `infixFunc`
eatInfixIdent :: Consumer
eatInfixIdent input = do
    chomped <- chompThis "`" input
    (token@Token{tokenClass=Tident ident}, chompedIdent) <- eatIdentifier chomped
    finalInput <- chompThis "`" chompedIdent
    Just (token{tokenClass=Toperator ident}, finalInput)

eatOperator :: Consumer
eatOperator input = eatInfixIdent input `orElse` eatOp input
    where
        isOperatorSymbol = (`elem` validOperatorSymbols)
        eatOp = eat (all isOperatorSymbol) (not . isOperatorSymbol) Toperator
        orElse x y = if isNothing x then y else x

eatReservedSymbol :: Consumer
eatReservedSymbol = msum . ([eatEager, eatOtherReservedSymbol] <*>) . pure
    where
        symbols = mconcat $ Map.keys reservedSymbols
        eagerSymbols = filter (not . (`elem` validOperatorSymbols)) symbols

        -- consume these tokens eagerly: ( ) { } [ ] ; , _
        eatEager (sym : rest, pos) | sym `elem` eagerSymbols =
            Just(Token (reservedSymbols Map.! [sym]) pos, (rest, pos{col=col pos + 1}))
        eatEager _ = Nothing

        eatOtherReservedSymbol =
            eat (`Map.member` reservedSymbols) (\c -> isSpace c || isAlphaNum c) (reservedSymbols Map.!)

eatIntLiteral :: Consumer
eatIntLiteral = eat (all isDigit) (not . isDigit) (TintLiteral . read)

eatFloatLiteral :: Consumer
eatFloatLiteral input = do
    (leftOfDecimal@Token{tokenClass=TintLiteral whole}, state1) <- eatIntLiteral input
    state2 <- chompThis "." state1
    (Token{tokenClass=TintLiteral decimal}, finalState) <- eatIntLiteral state2
    let floatVal = show whole ++ "." ++ show decimal
    Just(leftOfDecimal{tokenClass=TfloatLiteral $ read floatVal}, finalState)

eatCharLiteral :: Consumer
eatCharLiteral input = do
    chompedApost <- chompThis "'" input
    (charToken, chompedChar) <- eat ((== 1) . length) (== '\'') (TcharLiteral . head) chompedApost
    finalState <- chompThis "'" chompedChar
    Just(charToken, finalState)

eatStringLiteral :: Consumer
eatStringLiteral input = do
    chompedQuote <- chompThis "\"" input
    (str, chompedStr) <- eat (const True) (== '\"') TstringLiteral chompedQuote
    finalState <- chompThis "\"" chompedStr
    Just(str, finalState)

eatNewline :: Consumer
eatNewline input@(_, location) = do
    newState <- chompThis "\n" input
    Just(Token Tnewline location, newState)

consumers :: [Consumer]
consumers =
    [ eatKeyword
    , eatIdentifier
    , eatReservedSymbol
    , eatOperator
    , eatIntLiteral
    , eatFloatLiteral
    , eatCharLiteral
    , eatStringLiteral
    , eatNewline
    ]

{- 
Consume the next token, returns token and remaining input
-}
next :: Consumer
next (dropWhile isSpaceOrTab -> input, location) = msum $ consumers <*> pure (input, location)

lexer :: String -> [Token]
lexer input = theTokens where
    -- determine if user is using tabs or spaces for indentation
    firstChars = mapMaybe listToMaybe $ lines input
    indentChar = fromMaybe '\t' $ find isSpaceOrTab firstChars
    badIndentChar = if indentChar == '\t' then ' ' else '\t'

    -- return the leading number of indents of the given string
    chompTabs :: String -> (String, Int)
    chompTabs s
        | (next : _) <- rest, next == badIndentChar
        -- = error . show $ (leading, rest)
        = error $ "You're mixing indentation at :::" ++ take 50 rest ++ "::: Choose either tabs or spaces."
        | otherwise = (rest, length leading)
        where
            (leading, rest) = span (== indentChar) s


    -- lex on syntactically significant whitespace, skip past empty lines
    eatIndentations :: [Int] -> InputState -> ([Token], InputState, [Int])
    eatIndentations pastIndents (charStream, pos@Loc{line=line, col=col})
        -- empty line, ignore it
        | ('\n':skip) <- rest
        = eatIndentations pastIndents (skip, Loc{line=line+1, col=0})
        -- we have indented more, so report indent token
        | indent > head pastIndents
        = ([Token Tindent pos], newState, indent : pastIndents)
        -- this line has misaligned indentation
        | indent /= head newIndentStack
        = error $ "Orphaned indentation at :::" ++ take 15 rest ++ ":::"
        | otherwise
        -- take all past indents that are greater than this one off the stack and report tokens
        -- to close the indentation block
        = (replicate numDedents $ Token Tdedent pos, newState, newIndentStack)
        where
            (rest, indent) = chompTabs charStream
            numDedents = length $ takeWhile (> indent) pastIndents
            newState = (rest, pos{col=col+indent})
            newIndentStack = drop numDedents pastIndents

    scan :: [Int] -> InputState -> [Token]
    scan danglingIndents ("", pos) =
        Token Tnewline pos : replicate (length danglingIndents - 1) (Token Tdedent pos)
    scan indents inputState@(str, _)
        | Just (nextToken, nextState) <- next inputState
        = if tokenClass nextToken == Tnewline
            then nextToken : beginline indents nextState
            else nextToken : scan indents nextState
        | otherwise
        = error $ "Lexing error at :::" ++ take 15 str ++ ":::"

    -- lexer for when we are parsing from the beginning of a new line
    -- (handles significant whitespace)
    beginline :: [Int] -> InputState -> [Token]
    beginline indents inputState@(str, pos@Loc{line=lineNum})
        | (indentTokens, afterIndentState, newIndents) <- eatIndentations indents inputState
        = indentTokens ++ scan newIndents afterIndentState

    theTokens = beginline [0] (dropWhileEnd isSpace input, Loc 1 0)

