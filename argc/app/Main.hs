module Main where

import Parser
import Lex
import Token

dropRight :: Int -> [a] -> [a]
dropRight x ys = take (length ys - x) ys

main :: IO ()
main = do
    contents <- readFile "mytest.arg"
    putStr . show . parse . map tokenClass . lexer $ contents
    -- putStr . unlines . map show . lexer $ contents
