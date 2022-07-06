{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-
Parser combinators over my Tokens

-- think if we can generalize this and rewrite the lexer using this parser as well
-}
module ParseT where

import Token
import Data.Tuple
import Data.Maybe
import Control.Applicative (Alternative (..))
import Control.Monad (when)

data ErrType
  = Unexpected
  | CustomError String
  deriving Show

type ParseError input = (ErrType, input)

-- get the line at the given location in the string
displayProblem :: String -> Location -> String
displayProblem input Loc{line, col} = unlines ["at " ++ show line ++ "," ++ show col, theLine, whites ++ "^"]
  where
    theLine = fromMaybe "END OF INPUT" . listToMaybe . drop (line-1) . lines $ input
    whites = take col . map (\c -> if c == '\t' then '\t' else ' ') $ theLine

showError :: String -> ParseError i -> Location -> String
showError input (err, _) loc = unlines ["ERROR: " ++ show err, displayProblem input loc]


newtype ParseT input result = ParseT {run :: input -> Either (ParseError input) (result, input)}

-- class for the types that parsers can work on (ie a list of tokens, or a string with a location state)
class ParseState state where
  type El state   -- atomic unit to read from the parse state
  getNext :: state -> Maybe (El state, state)

-- map over the parsed value
instance Functor (ParseT input) where
  fmap f (ParseT k) = ParseT (fmap (mapFst f) . k)
    where mapFst f = swap . fmap f . swap

instance Applicative (ParseT input) where
  pure a = ParseT (\input -> Right (a, input))

  ParseT f <*> ParseT p = ParseT $ \input -> do
      (f', rest) <- f input
      (output, rest') <- p rest
      pure (f' output, rest')

-- bind results in a new parser that runs the first,
-- uses the output to create a another parser which is
-- run on the remaining input
instance Monad (ParseT input) where
  ParseT p >>= f = ParseT $ \input -> do
    (got, rest) <- p input
    run (f got) rest

instance ParseState input => MonadFail (ParseT input) where
  fail = const empty

instance ParseState input => Alternative (ParseT input) where
  empty = ParseT $ \input -> case getNext input of
    Just (item, rest) -> Left (CustomError "Born to fail", input)
    Nothing -> Left (Unexpected, input)

  ParseT p <|> ParseT q = ParseT $ \input ->
    case p input of
    Left pe -> q input
    success -> success


-- simple parser that will accept a token if it satisfies some predicate
satisfy :: ParseState input => (El input -> Bool) -> ParseT input (El input)
satisfy p = ParseT $ \input -> case getNext input of
    Just (hd, rest) | p hd -> Right (hd, rest)
    _ -> Left (Unexpected, input)

chompWhile :: ParseState input => (El input -> Bool) -> ParseT input [El input]
chompWhile p = many (satisfy p)

attempt :: ParseState input => (El input -> Maybe output) -> ParseT input output
attempt f = ParseT $ \input -> case getNext input of
  Just (hd, rest) | Just x <- f hd -> Right (x, rest)
  _ -> Left (Unexpected, input)

-- retrieve the next element from the parser state
next :: ParseState input => ParseT input (El input)
next = satisfy (const True)

-- retrieve the current parser state
getState :: ParseT input input
getState = ParseT $ \input -> Right (input, input)

setState :: input -> ParseT input ()
setState newState = ParseT $ \_ -> Right ((), newState)

modifyState :: (input -> input) -> ParseT input ()
modifyState modder = do
  state <- getState
  setState $ modder state

-- run the given parser without consuming any input
lookAhead :: ParseT a b -> ParseT a b
lookAhead p = ParseT $ \input -> case run p input of
  Left pe -> Left pe
  Right (res, _) -> Right (res, input)

-- parse the next element without consuming it
peek :: ParseState input => ParseT input (El input)
peek = lookAhead next

-- returns True if this parser will succeed
-- returns False if it will fail
isNext :: ParseState a => ParseT a b -> ParseT a Bool
isNext p = (lookAhead p >> return True) <|> pure False

single :: (ParseState input, Eq (El input)) => El input -> ParseT input (El input)
single x = satisfy (== x)

seq :: (ParseState input, Eq (El input)) => [El input] -> ParseT input [El input]
seq = traverse single

oneOf :: ParseState a => [ParseT a b] -> ParseT a b
oneOf = foldl (<|>) empty


-- if true, error with the given string
errorIf :: Bool -> String -> ParseT i ()
errorIf cond err = when cond $ ParseT $ \input -> Left (CustomError err, input)

-- parse something that is enclosed between two items
-- discard the enclosing items
enclosed :: ParseT a x -> ParseT a y -> ParseT a z -> ParseT a z
enclosed left right p = do
  left
  e <- p
  right
  return e

-- alternative between the given parser and a modified version of it
maybeWith :: ParseState a => (ParseT a b -> ParseT a b) -> ParseT a b -> ParseT a b
maybeWith modifier p = modifier p <|> p

try :: ParseState a => ParseT a b -> ParseT a (Maybe b)
try p = fmap Just p <|> pure Nothing

-- confirm end of input has been reached
end :: ParseState a => ParseT a ()
end = ParseT $ \input -> case getNext input of
  Nothing -> Right ((), input)
  _ -> Left (CustomError "I wasn't expecting any more tokens", input)

nonEmptyListOf :: ParseState i => ParseT i d -> ParseT i a -> ParseT i [a]
nonEmptyListOf delim pitem = do
  item <- pitem
  rest <- many (delim >> pitem)
  return $ item : rest

-- parse a list of a's separated by some delimiter
listOf :: ParseState i => ParseT i d -> ParseT i a -> ParseT i [a]
listOf delim pitem = nonEmptyListOf delim pitem <|> pure []
