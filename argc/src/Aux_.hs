import Lex
import Token (Token(Token))
printA toks = do
  putStrLn . unlines . map showTok $ toks
  putStrLn "with remaining state"



showTok (Token tok loc) =
  let
    tokstr = show tok
    l = length tokstr
    padding = replicate (20 - l) ' '
  in
    tokstr ++ padding ++ show loc

go = do
  contents <- readFile "..\\mytest.arg"
  printA $ lexer contents