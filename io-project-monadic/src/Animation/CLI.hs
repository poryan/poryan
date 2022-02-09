module Animation.CLI where

import Animation.State

import System.Environment (getArgs)

-- (>>=) :: IO a -> (a -> IO b) -> IO b
-- return :: a -> IO a
cli :: IO (Env, State)
-- cli = getArgs >>= (\unparsedArgs -> return (parseArgs unparsedArgs))
cli = fmap parseArgs getArgs

parseArgs :: [String] -> (Env, State)
parseArgs [frameX, frameY, posX, posY, dirX, dirY] = ((Env (read frameX, read frameY)), (State (read posX, read posY) (read dirX, read dirY)))
parseArgs _ = error "The correct format to use binary is ./Animate frameX frameY posX posY dirX dirY"

