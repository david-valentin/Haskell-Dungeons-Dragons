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


getConnection :: String -> IO Connection
getConnection db = open db

closeConnection :: Connection -> IO ()
closeConnection conn = close conn
