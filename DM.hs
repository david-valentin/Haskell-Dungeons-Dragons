{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad
import System.Random
import Data.Int
import Data.List
import qualified Data.Text as T
import System.Exit
import qualified Data.Map as Map
import Text.PrettyPrint.Boxes
import  Database.SQLite.Simple

import Parser
import Haskell_DB
import CharacterLibrary


main :: IO ()
main = do
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
               putStrLn "Character Name?"
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
                        putStrLn ""
                        putStrLn "Remaining abilities to set"
                        putStrLn "---------------------------"
                        mapM_ putStrLn (Map.keys m)
                        putStrLn "---------------------------"
                        putStrLn ""
                        putStrLn "What ability do you want to set this to?"
                        d <- getLine
                        case Map.lookup (T.unpack . T.toLower $ (T.pack d)) m of
                          Nothing -> putStrLn "You already set this ability or it doesn't exist, lets try that again!"
                                      >> getAbilities a m
                          Just e -> do
                                    getAbilities ((m Map.! (T.unpack . T.toLower $ (T.pack d)) ) a b) (Map.delete (T.unpack . T.toLower $ (T.pack d)) m)

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
              putStrLn "Ok, Let's get started"
              --ask ready take y/n do rest on y wait on n
              putStrLn "-------------------------------------------------------"
              pc <- createPlayer
              putStr "Your Character is "
              print pc
              putStrLn "Ready to start the game? (y/n)"
              ans <- getLine
              --   when (ans == "y") do
              conn <- getConnection "Dnd.db"
              playGame pc conn "Null"

playGame :: PC -> Connection -> String -> IO ()
playGame pc conn s = do
                r <- query conn "select * from mainstory where rootchoice = ?" (Only(T.pack s :: T.Text)) :: IO [MainStory_Schema]
                forM_ r $ \l -> do
                            print . T.unpack $ event l --change to putstrln once db is fixed
                            putStrLn "You have 2 choices"
                            putStrLn . T.unpack $ choice1 l
                            putStrLn . T.unpack $ choice2 l
                putStr "What will it be? "
                ans <- getLine
                getChoice pc ans --getChoice isnt working as expected!!
                playChoice conn 3

playChoice :: Connection -> Int -> IO ()
playChoice conn i = putStrLn "Something"

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
