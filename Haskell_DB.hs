{-# LANGUAGE OverloadedStrings #-}
import           Control.Applicative
import qualified Data.Text as T
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow

data DnD_Schema = DnD_Schema Int T.Text T.Text Int Int deriving (Show)

instance FromRow DnD_Schema where
  fromRow = DnD_Schema <$> field <*> field <*> field <*> field <*> field


instance ToRow DnD_Schema where
  toRow (DnD_Schema id_ ty text ca cb) = toRow (id_, ty, text, ca, cb)

main :: IO ()
main = do
  conn <- open "test.db"
  execute_ conn "CREATE TABLE IF NOT EXISTS DnD (id INTEGER PRIMARY KEY ASC, EventType Text, TextEvent Text, choiceA INTEGER, choiceB INTEGER)"
  execute conn "INSERT INTO DnD (id, EventType, TextEvent, choiceA, choiceB) VALUES (?, ?, ?, ?, ?)" ((1 :: Int), ("action_event" :: String), ("You come across a [active_location_description] [active_location] and see a [active_group_description] of [creature]. The creatures have not noticed you yet and so you have time to decide." :: String), (1 :: Int), (2 :: Int))
  print "Created"
  close conn
