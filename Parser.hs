module Parser where

import Text.ParserCombinators.Parsec
import qualified Data.List.Split as List
import Data.List
-- import Data.Random.Extras

data Option = Help
            | Choose (Char)
            | Stats
            -- | Quit
      deriving Show

-- :c = chooseEvent
-- :h = help
-- :s = stats
-- :q = Quit
parseOptions :: Parser Option
parseOptions = do {
          spaces --handle whitespace in beginning of command
          ; char ':'
          ; parseChoice <|> parseHelp <|> parseStats
          }

parseStats :: Parser Option
parseStats = do {
            char 's'
            -- nothing but white space
            ; return Stats
            }

parseHelp :: Parser Option
parseHelp = do {
            char 'h'
            ; return Help
            }
parseChoice :: Parser Option
parseChoice = do {
              char 'c'
              ; spaces
              ; choice <- oneOf "abAB"
              ; return $ Choose choice
              }

-- parseQuit :: Parser Option
-- parseQuit = do {
--             char 'q'
--             ; return Quit
--             }

--For testing purposes
run :: Show a => Parser a -> String -> IO ()
run = parseTest

--------------------------------------------------------------------------------
madLib :: [String]
madLib = ["[Creature]", "[Cadj]"]

choices :: [[String]]
choices = [creatures, cadjs]

 --Look into Vectors
creatures :: [String]
creatures = ["kobold", "orc", "bulette", "gelatinous cube"]

cadjs :: [String]
cadjs =  ["big", "huge", "puney"]

parsePlot :: String -> [String] -> String
parsePlot s [] = s
parsePlot s (x:xs) = parsePlot (findAndReplace "test" x s) xs


findAndReplace ::  String -> String -> String -> String
findAndReplace new old s = intercalate new . List.splitOn old $s
