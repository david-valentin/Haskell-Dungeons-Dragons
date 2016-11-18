import Text.ParserCombinators.Parsec

-- :c = chooseEvent
-- :h = help
-- :s = stats
-- :p = peek
options :: Parser Char
options = do {
          skipMany space --handle whitespace in beginning of command
          ; char ':'
          ; oneOf "chsp" <* skipMany1 space
          }

-- For testing purposes Use Parsetest
run :: Show a => Parser a -> String -> IO ()
run p input =
      case (parse p "" input) of
        Left err -> do
                    {putStr "parse error at "
                    ; print err
                    }
        Right x -> print x
