module Main where

import Control.Monad
import Parser

main :: IO ()
main = do
 line <- getLine
 lp <- run parseOptions line -- need to silence this 
 unless (line == ":q") $ do
   print lp
   main
