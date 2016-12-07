module CharacterLibrary where
-- a = Creature Name - i.e. Goblin
-- b = Creature Health - 5
-- c = Creature Damage - 2

-- Formula for Difficulty =

-- Goblins = [0.1 - 0.2] * eventLevel
-- Troll = [0.2 - 0.4] * eventLevel
-- Bandit = [0.3 - 0.5] * eventLevel
-- Dragon = [0.6 - 0.8] * evenLevel

<<<<<<< HEAD
data Race = Halfling
          | Dwarf
          | Human
          | Elf
          deriving (Show)

data Classc = Cleric
           | Fighter
           | Rogue
           | Wizard
           deriving (Show)

data Typec = Humanoids
          | Dragons
          | Monstrosities
          | Plants
          deriving (Show)

data Abilities = Abilities { strength :: Int,
                           dexterity :: Int,
                           costitution :: Int,
                           intelligence :: Int,
                           wisdom :: Int,
                           charisma :: Int,
                           level :: Int,
                           xp :: Int
                           } deriving (Show)

data Item = Item { itemName :: String,
                   boost :: Int
                 } deriving (Show)


data PC = PC { statsPC :: Abilities,
                   name :: String,
		               race :: String,
                   classPC :: String,
                   bag :: [Item]
                 } deriving (Show)

data NPC = NPC { statsNPC :: Abilities,
                     typeNPC :: Typec,
                     size :: Int,
                     cr :: Int
                   } deriving (Show)

setStr :: Abilities -> Int -> Abilities
setStr (Abilities s d c i w ch l x) ns = Abilities ns d c i w ch l x

setDex :: Abilities -> Int -> Abilities
setDex (Abilities s d c i w ch l x) nd = Abilities s nd c i w ch l x

setCost :: Abilities -> Int -> Abilities
setCost (Abilities s d c i w ch l x) nc = Abilities s d nc i w ch l x

setWis :: Abilities -> Int -> Abilities
setWis (Abilities s d c i w ch l x) nw = Abilities s d c i nw ch l x

setCha :: Abilities -> Int -> Abilities
setCha (Abilities s d c i w ch l x) nch = Abilities s d c i w nch l x

getStats :: PC -> Abilities
getStats (PC a _ _ _ _) = a
=======



datatype Creature = Creature { Type :: String,
                               Health :: Int,
                               Weight :: Float
                               }
                               deriving (Show)




-- 15 points distributed how they want.
-- Strength = Damage you can deal
-- Intelligence = Access to doors/certain events

-- Players always get first hit. Creature hits back -

-- List Items:

let passive_locations  = ["inn", "village", "parish", "hamlet", "settlement", "pub", "tavern"]

let passive_characters = ["barkeep", "villager", "boy"]

let puzzle_locations = ["door", "gate", "gargoyle", "writings"]

let puzzle_descriptions = ["mysterious", "cryptic", "obscure", "puzzling"]

let active_location = ["pasture", "cave", "dungeon", "plains", "wasteland", "mine"]

let active_location_description = ["misty", "cold", "dark", "dusty"]

let active_group_description = ["platoon", "group", "division", "unit", "gang", "pack", "mob", "band"]



datatype Interaction = Interaction { Description :: String
                                     Requirements :: (Int, String)
                                     Loot :: Item
											}


-- Items are randomly given by villagers or unlocked items
datatype Item = { ItemName :: String,
		  Boost :: Int }


datatype Hero = Hero { Name :: String,
                       Health :: Int,
		       Strength :: Int,
                       Intelligence :: Int,
                       Charm :: Int,
                       Bag :: [Item]
                       Type :: String
                       }

datatype Event = ActiveEvent Creature Plot
               | PassiveEvent Interaction Plot
>>>>>>> f906f6e12b405405c7360329c8804dfc0175a4ad
