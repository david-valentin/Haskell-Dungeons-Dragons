module Main where

import Control.Monad
import System.Random
import Data.Int
import System.Exit
import qualified Data.Map as Map

import Parser
import CharacterLibrary


main :: IO ()
main = do
  --Set up Game/Create Character
  pc <- createPlayer
  putStr "Your Character is "
  print pc
  putStrLn "Ready to start the game? (y)"
  ans <- getLine
  -- when (ans == "y") --start game
  ----------------------------------------------
  l <- getLine
  getChoice pc l
  main
  --play
    --Start Game/Pick Story
    --Pick Plot Line/Wait for response/go to next/repeat




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
                        putStr "Rolling 4d6... your roll is "
                        b <- rollDie
                        print b
                        putStrLn "What attribute do you want to set this to?"
                        d <- getLine
                        case Map.lookup d m of
                          Nothing -> putStrLn "You already set this ability, lets try this again!"
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
                     Right Stats -> pure $ show $ getStats c
                     Left err -> pure " There was an error in the parse"

quitGame :: IO String
quitGame = do
           putStr "are you sure you want to quit (y/n)"
           ans <- getLine
           when (ans == "y") exitSuccess --how do i silence this
           return "Ok"
--------------------------------------------------------------------------------
setAbs = Map.fromList [("strength", setStr), ("dexderity", setDex), ("constitution", setCost),
              ("intelligence", setIntel),("wisdom", setWis), ("charisma", setCha) ]
