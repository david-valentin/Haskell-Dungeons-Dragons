module Parser where

import Text.ParserCombinators.Parsec
import qualified Data.List.Split as List
import Data.List
import qualified Data.Map as Map

data Option = Help
            | Choose (Char)
            | Stats
            | Quit
      deriving Show

-- :c = chooseEvent
-- :h = help
-- :s = stats
-- :q = Quit
parseOptions :: Parser Option
parseOptions = do {
          spaces --handle whitespace in beginning of command
          ; char ':'
          ; parseChoice <|> parseHelp <|> parseStats <|> parseQuit
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

parseQuit :: Parser Option
parseQuit = do {
            char 'q'
            ; return Quit
            }

--For testing purposes
run :: GenParser tok st a -> st -> SourceName -> [tok] -> Either ParseError a
run = runParser

--------------------------------------------------------------------------------
parsePlot :: String -> [String] -> Int -> String
parsePlot s [] _ = s
parsePlot s (x:xs) r = parsePlot (findAndReplace new x s) xs r
        where new = m !! (r `mod` length m)
              m = (madLib Map.! x)

findAndReplace ::  String -> String -> String -> String
findAndReplace new old s = intercalate new . List.splitOn old $s

--------------------------------------------------------------------------------
passive_location  = ["inn", "village", "parish", "hamlet", "settlement", "pub", "tavern"]
passive_character = ["barkeeper", "villager", "boy", "girl"]
puzzle_locations = ["door", "gate", "gargoyle", "writings"]
puzzle_descriptions = ["mysterious", "cryptic", "obscure", "puzzling"]
active_location = ["pasture", "cave", "dungeon", "plains", "wasteland", "mine"]
active_location_description = ["misty", "cold", "dark", "dusty"]
active_group_description = ["platoon", "group", "division", "unit", "gang", "pack", "mob", "band"]

madLib = Map.fromList [("passive_location", passive_location), ("passive_character", passive_character)]
