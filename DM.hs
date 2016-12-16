module Main where

import Control.Monad
import System.Random
import Data.Int
import Data.List
import System.Exit
import qualified Data.Map as Map
import Text.PrettyPrint.Boxes

import Parser
import Haskell_DB
import CharacterLibrary



main :: IO ()
main = do
  --Set up Game/Create Character
  pc <- createPlayer
  putStr "Your Character is "
  print pc
  putStrLn "Ready to start the game? (y/n)"
  ans <- getLine
  when (ans == "y")
    startGame
  ----------------------------------------------
  -- start game
    -- Display commands (check)
    -- Start Game/Pick Story Line (eh)
    -- Get intro for story line
    -- Pick Plot Line/Wait for response/go to next/repeat



---------------------------------helpers---------------------------------------
createPlayer :: IO PC
createPlayer = do
               putStrLn "Name?"
               name <- getLine
               putStrLn "Race?"
               race <- getLine
               putStrLn "Class?"
               c <- getLine
               ab <- getAbilities (Abilities 0 0 0 0 0 0 1 100) setAbs
               return (PC ab name race c [])

getAbilities :: Abilities -> (Map.Map String (Abilities -> Int -> Abilities)) -> IO Abilities
getAbilities a m = do
                    if (Map.null m == False)
                      then do
                        putStr "Rolling dice... your roll is "
                        b <- rollDie
                        print b
                        putStrLn "What ability do you want to set this to?"
                        d <- getLine
                        case Map.lookup d m of
                          Nothing -> putStrLn "You already set this ability or it doesn't exist, lets try that again!"
                                      >> getAbilities a m
                          Just e -> do
                                    getAbilities ((m Map.! d) a b) (Map.delete d m)

                    else
                      return a

getRand :: IO Int
getRand = randomRIO (1, maxBound)

rollDie :: IO Int
rollDie = randomRIO (3,18)

getChoice :: PC -> String -> IO String
getChoice c l = case run parseOptions () "" l of
                     Right Quit -> quitGame
                     Right Help -> pure "Some helpful string here"
                     Right (Choose x) -> pure "make choice option"--some choice
                     Right Stats -> pure $ show $ statsPC c
                     Left err -> pure " There was an error in the parse"

quitGame :: IO String
quitGame = do
           putStr "are you sure you want to quit (y/n)"
           ans <- getLine
           when (ans == "y") exitSuccess --how do i silence this
           return "Ok"

startGame :: IO ()
startGame = do
              putStr "\n"
              putStr "Welcome to the game! Its gonna be super lit. But first..."
              help
              putStr "Let's get started"
              conn <- getConnection "Dnd.db"
              playGame conn

playGame :: Connection -> IO ()
playGame conn = do {
                
                }

help :: IO ()
help = do
        putStr "\n"
        putStr "This is the help section and a "
        putStrLn "basic list of commands to be used during game play"
        printTable helpText
        putStr "\n"


printTable :: [[String]] -> IO ()
printTable rows = printBox $ hsep 2 left (map (vcat left . map text) (transpose rows))
--------------------------------------------------------------------------------
setAbs = Map.fromList [("strength", setStr), ("dexterity", setDex), ("constitution", setCost),
              ("intelligence", setIntel),("wisdom", setWis), ("charisma", setCha) ]
helpText = [[":s","Check the current stats of your character"],[":q","Quit the game :("],
            [":h","Display the help section"], [":c _", "finalize your decision; _ denotes your choice"]]
