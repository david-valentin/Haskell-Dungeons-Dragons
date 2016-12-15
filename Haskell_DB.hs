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
  execute_ conn "CREATE TABLE IF NOT EXISTS outcomes (id INTEGER PRIMARY KEY ASC, EventType Text, Event Text, outcome BOOL)"
  execute_ conn "CREATE TABLE IF NOT EXISTS choices (id INTEGER PRIMARY KEY ASC, EventType Text, Event Text, choice1 INTEGER, choice2 INTEGER)"
  execute_ conn "CREATE TABLE IF NOT EXISTS mainStory (id INTEGER PRIMARY KEY ASC, Event Text, choice1 Text, choice2 Text, rootChoice Text)"
  -- outcomes table - id INTEGER PRIMARY KEY ASC, EventType Text, Event Text, outcome BOOL
  execute conn "INSERT INTO outcomes (id, EventType, Event, outcome) VALUES (?, ?, ?, ?)" ((1 :: Int), ("action_event" :: String), ("With swift foot and heavy sword in hand, you both rush into the battle and catch them off guard. It is a complete victory as you vanquish your foes. Some of the [ACTIVE CHARACTERS] run off in the distance and are clearly afraid of your combined might. You swiftly defeat them and continue on your journey.":: String), (True :: Bool))
  execute conn "INSERT INTO outcomes (id, EventType, Event, outcome) VALUES (?, ?, ?, ?)" ((2 :: Int), ("action_event" :: String), ("With swift foot and heavy sword in hand, you both rush into the battle and catch them off guard. It is a complete victory as you vanquish your foes. Some of the [ACTIVE CHARACTERS] run off in the distance and are clearly afraid of your combined might. You swiftly defeat them and continue on your journey." :: String), (False :: Bool))
  execute conn "INSERT INTO outcomes (id, EventType, Event, outcome) VALUES (?, ?, ?, ?)" ((3 :: Int), ("puzzle_event" :: String), ("After studying the [puzzle_location], you realize the pattern within the structure. After using your pattern matching skills, you discover a secret lever and it reveals a chest. You open the chest to reveal [reward_item]. With this discovery, you will be stronger and ready to defeat Retep. You continue on your journey." :: String), (True :: Bool))
  execute conn "INSERT INTO outcomes (id, EventType, Event, outcome) VALUES (?, ?, ?, ?)" ((4 :: Int), ("puzzle_event" :: String), ("After studying the [puzzle_location], you cannot seem to figure out the pattern within the structure. It is growing dark and you realize you are not capable of solving this puzzle and should continue on your journey. Some doubts set in on how you will be able to defeat Retep with your poor pattern matching skills. You both continue on your journey." :: String), (False :: Bool))
  execute conn "INSERT INTO outcomes (id, EventType, Event, outcome) VALUES (?, ?, ?, ?)" ((5 :: Int), ("puzzle_event" :: String), ("After studying the [puzzle_location], you cannot seem to figure out the pattern within the structure. It is growing dark and you realize you are not capable of solving this puzzle and should continue on your journey. Some doubts set in on how you will be able to defeat Retep with your poor pattern matching skills. You both continue on your journey." :: String), (False :: Bool))
  execute conn "INSERT INTO outcomes (id, EventType, Event, outcome) VALUES (?, ?, ?, ?)" ((6 :: Int), ("risk_event" :: String), ("As you cross through [risk_location], you notice an unstable structure up ahead from some ancient civilization years ago. Being a perceptive hero, you decide to rush through quickly and making sure that you make it out quickly. By the time you make it out of the [risk_location], the structure collapses onto itself. It seems like you are still able to continue your journey." :: String), (True :: Bool))
  -- /outcomes
  -- mainStory table: columns id INTEGER PRIMARY KEY ASC, Event Text, choice1 Text, choice2 Text, outcomeChoice Text
  execute conn "INSERT INTO mainStory (id, Event, choice1, choice2, rootChoice) VALUES (?, ?, ?, ?, ?)" ((1 :: Int), ("Long ago, when the world was ruled by dragons and bloodshed, there rose a hero from an unknown rural village hidden in the mountains of Middle Endian to fight the dragons. The hero used an ancient weapon known as Garamax’s Hilt of Cordigon Infinity…or GHCi for short to defeat the dragons, and the ancient weapon was built by the old masters before the dragons. In a final battle, he used this weapon to defeat Retep, the Emerald Dragon, and was able to trap Retep in an infinite chain. But now, with the new GHCi update – I mean with the full moon it seems that the infinite chain spell is broken, and Retep has awakened and plans to awaken the other dragons, yet the mysterious hero is nowhere to be found. Legend has it that with every great evil, a new hero will arise. The question now arises: Will you be the new hero?" :: String), ("[A] Yes" :: String), ("[B] :: No" :: String), ("Null" :: String))
  execute conn "INSERT INTO mainStory (id, Event, choice1, choice2, rootChoice) VALUES (?, ?, ?, ?, ?)" ((2 :: Int), ("Okay, well goodbye!" :: String), ("[A] Yes" :: String), ("[B] No" :: String), ("[B]" :: String))
  execute conn "INSERT INTO mainStory (id, Event, choice1, choice2, rootChoice) VALUES (?, ?, ?, ?, ?)" ((3 :: Int), ("You finally make it to the the Retep’s lair. You enter in quietly trying to find the dragon. You see troves of these shiny metal machines humming along the caverns. They glow in the darkness softly. You continue walking into the end of the lair only to find a smaller machine that glows in the dark. It looks like the mysterious GHCi weapon the old ones had built. Its hums your name and beckons you. Before you can take a step further, you hear a ghostly voice. With your sword in hand you turn and see a man dressed in some blue jeans and some running shoes, and with pretty standard t-shirt." :: String), ("[A] Ask him to reveal yourself" :: String), ("[B] Attack him" :: String), ("" :: String))
  execute conn "INSERT INTO mainStory (id, Event, choice1, choice2, rootChoice) VALUES (?, ?, ?, ?, ?)" ((4 :: Int), ("The man tells you that he is Retep. Before you draw your sword, he explains to you his story. Retep explains he was once a man, but his research into the workings of the GHCi had transformed him into an evil dragon known as Retep as there was an error in his code which trapped him in an infinite list. A mysterious hero found him in his lair and was able to free him by fixing his code, but now there is a new problem has arisen. He asks you to solve several problems or else he tells you he will transform into a dragon and wreak havoc. He gives you the following problem: Build a function that finds the kth element of a list called ‘elementat’. Separate lines of code with ; character. Cases: 1. elementAt [] 0 = [] 2. elementAt [] 1 = [] 3. elementAt [1,2,3] 1 = 1" :: String), ("Type your answer separated by ;" :: String), ("NULL" :: String), ("[A]" :: String))
  execute conn "INSERT INTO mainStory (id, Event, choice1, choice2, rootChoice) VALUES (?, ?, ?, ?, ?)" ((5 :: Int), ("As you strike down Retep with your sword, the man transforms into a dragon and shields himself from your attack, which knocks you against the glowing, humming machines. It seems like Retep will soon die as he shift his form from dragon to man to someone who looks like they teach or something. The GHCi machine glows and beckons you to it. A problem appears on the screen: Build a function that finds the kth element of a list called ‘elementat’. Separate lines of code with ; character. Cases: 1. elementAt [] 0 = [] 2. elementAt [] 1 = [] 3. elementAt [1,2,3] 1 = 1" :: String), ("Type your answer separated by ;" :: String), ("" :: String), ("[B]" :: String))
  execute conn "INSERT INTO mainStory (id, Event, choice1, choice2, rootChoice) VALUES (?, ?, ?, ?, ?)" ((6 :: Int), ("Retep thanks you for your effort and continues with his research into the GHCi. You question whether he should continue to research into such a powerful weapon, but understanding the GHCi may prove helpful in the future. You leave the lair, and it seems like your journey has come to an end." :: String), ("[A] End" :: String), ("[A] End" :: String), ("" :: String))
  execute conn "INSERT INTO mainStory (id, Event, choice1, choice2, rootChoice) VALUES (?, ?, ?, ?, ?)" ((7 :: Int), ("It seems like you have stopped his research into the GHCI. The machine glows and continues to beckon you, but rather than going to the machine, you smash it with your sword. All the other machines stop humming in the lair as you trace your way out of the lair now blind. Your journey comes to an end, but the world seems slightly dimmer." :: String), ("[A] End" :: String), ("[B] End" :: String), ("" :: String))
  print "Created"
  close conn


getConnection :: String -> IO Connection
getConnection db = open db

closeConnection :: Connection -> IO ()
closeConnection conn = close conn
