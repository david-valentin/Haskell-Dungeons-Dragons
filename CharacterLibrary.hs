
-- a = Creature Name - i.e. Goblin
-- b = Creature Health - 5
-- c = Creature Damage - 2

-- Formula for Difficulty =

-- Goblins = [0.1 - 0.2] * eventLevel
-- Troll = [0.2 - 0.4] * eventLevel
-- Bandit = [0.3 - 0.5] * eventLevel
-- Dragon = [0.6 - 0.8] * evenLevel




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
