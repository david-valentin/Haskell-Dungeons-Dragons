{-# LANGUAGE OverloadedStrings #-}
import           Control.Applicative
import qualified Data.Text as T
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow

data TestField = TestField Int T.Text deriving (Show)

instance FromRow TestField where
  fromRow = TestField <$> field <*> field <*> field

instance ToRow TestField where
  toRow (TestField id_ str) = toRow (id_, str, int)

main :: IO ()
main = do
  conn <- open "test.db"
  execute_ conn "CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY, str TEXT)"
  execute conn "INSERT INTO test (str, int) VALUES (?, ?)" (("You both come across a [ADJ] [LOCATION] and see a [GROUP_DESCRIPTION] of [STAT_DESCRIPTION] [CREATURE]. The creatures have not noticed you both yet and so you have time to decide." :: String, 5 :: Int))
  r <- query_ conn "SELECT * from test" :: IO [TestField]
  mapM_ print r
  close conn
