module Main where

-- import Parser
import Lex
import Token

main :: IO ()
main = do
    contents <- readFile "mytest.arg"
    --putStr . show . parse $ contents
    putStr . unlines . map show . lexer $ contents
