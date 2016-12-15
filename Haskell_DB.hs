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
  conn <- open "Dnd.db"
  -- execute_ conn "CREATE TABLE IF NOT EXISTS outcomes (EventType Text, Event Text, outcome BOOL)"
  -- execute_ conn "CREATE TABLE IF NOT EXISTS choices (id INTEGER PRIMARY KEY ASC, EventType Text, Event Text, choice1 INTEGER, choice2 INTEGER)"
  execute conn "INSERT INTO outcomes (EventType, Event, outcome) VALUES (?, ?, ?)" (("action_event" :: String), ("With swift foot and heavy sword in hand, you both rush into the battle and catch them off guard. It is a complete victory as you vanquish your foes. Some of the [ACTIVE CHARACTERS] run off in the distance and are clearly afraid of your combined might. You swiftly defeat them and continue on your journey.":: String), (True :: Bool))
  execute conn "INSERT INTO outcomes (EventType, Event, outcome) VALUES (?, ?, ?)" (("action_event" :: String), ("With swift foot and heavy sword in hand, you both rush into the battle and catch them off guard. It is a complete victory as you vanquish your foes. Some of the [ACTIVE CHARACTERS] run off in the distance and are clearly afraid of your combined might. You swiftly defeat them and continue on your journey." :: String), (False :: Bool))
  execute conn "INSERT INTO outcomes (EventType, Event, outcome) VALUES (?, ?, ?)" (("puzzle_event" :: String), ("After studying the [puzzle_location], you realize the pattern within the structure. After using your pattern matching skills, you discover a secret lever and it reveals a chest. You open the chest to reveal [reward_item]. With this discovery, you will be stronger and ready to defeat Retep. You continue on your journey." :: String), (True :: Bool))
  execute conn "INSERT INTO outcomes (EventType, Event, outcome) VALUES (?, ?, ?)" (("puzzle_event" :: String), ("After studying the [puzzle_location], you cannot seem to figure out the pattern within the structure. It is growing dark and you realize you are not capable of solving this puzzle and should continue on your journey. Some doubts set in on how you will be able to defeat Retep with your poor pattern matching skills. You both continue on your journey." :: String), (False :: Bool))
  execute conn "INSERT INTO outcomes (EventType, Event, outcome) VALUES (?, ?, ?)" (("risk_event" :: String), ("As you cross through [risk_location], you notice an unstable structure up ahead from some ancient civilization years ago. Being a perceptive hero, you decide to rush through quickly and making sure that you make it out quickly. By the time you make it out of the [risk_location], the structure collapses onto itself. It seems like you are still able to continue your journey." :: String), (True :: Bool))
  execute conn "INSERT INTO outcomes (EventType, Event, outcome) VALUES (?, ?, ?)" (("risk_event" :: String), ("As you cross through [risk_location], the ground begins to shake. You quickly notice a rockslide up ahead and begins crashing down. You rush quickly through the [RISK LOCATION] to avoid certain death; however, in the process you both become injured. You lose [num_gen] in your [stat]." :: String), (False :: Bool))
  print "Created"
  close conn
