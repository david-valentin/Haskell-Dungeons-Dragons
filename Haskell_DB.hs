{-# LANGUAGE OverloadedStrings #-}
import Control.Applicative
import Database.SQLite.Simple
import Data.Text as T
import Database.SQLite.Simple.FromRow

data Main_Storyline = Main_Storyline Int T.Text deriving (Show)

instance FromRow Main_Storyline where
  fromRow = Main_Storyline <$> field <*> field


instance ToRow Main_Storyline where
  toRow (Main_Storyline id_ str) = toRow (id_, str)

main :: IO ()
main = do
  conn <- open "test.db"
  execute_ conn "CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY, str TEXT)"
  execute conn "INSERT INTO test (str, Int VALUES (?)" (Only ("The hero come across a [ADJ] [LOCATION] and sees a [GROUP_DESCRIPTION] of [CREATURE]. The creatures have not noticed you yet and so you have some time to decide." :: String, 1 :: Int, 2 :: Int))
  get_all <- query_ conn "Select * from test" :: IO [Main_Storyline]
  mapM_ print get_all
  close conn
