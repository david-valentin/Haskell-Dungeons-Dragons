module CharacterLibrary where
-- a = Creature Name - i.e. Goblin
-- b = Creature Health - 5
-- c = Creature Damage - 2

-- Formula for Difficulty =

-- Goblins = [0.1 - 0.2] * eventLevel
-- Troll = [0.2 - 0.4] * eventLevel
-- Bandit = [0.3 - 0.5] * eventLevel
-- Dragon = [0.6 - 0.8] * evenLevel

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

setIntel :: Abilities -> Int -> Abilities
setIntel (Abilities s d c i w ch l x) ni = Abilities s d c ni w ch l x

setWis :: Abilities -> Int -> Abilities
setWis (Abilities s d c i w ch l x) nw = Abilities s d c i nw ch l x

setCha :: Abilities -> Int -> Abilities
setCha (Abilities s d c i w ch l x) nch = Abilities s d c i w nch l x

getStats :: PC -> Abilities
getStats (PC a _ _ _ _) = a
