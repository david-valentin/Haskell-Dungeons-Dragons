import System.IO
import System.Environment
import Data.List

main = do
   args <- getStats
   totalStats <- 15
   
   putStrLn (5 - args)


getStats :: Integer
getStats = toInteger (getLine)
