module Animation.Animate where

import Animation.State ( next, Env, State (position, direction) )
import Animation.Draw ( drawState )
import Control.Monad.Reader (ReaderT,liftIO,lift,ask)
import Control.Monad.State(StateT,get,put)
import Control.Monad.Writer(WriterT,tell)


import Control.Concurrent (threadDelay, getChanContents)

animate :: WriterT String (StateT State (ReaderT Env IO)) ()
animate = do
    env <- ask
    currState <- get
    tell ("Writing to postion coords " ++ show (position currState) ++ " and direction " ++ show (direction currState))
    liftIO clearScreen
    liftIO $ putStr (drawState env currState)
    liftIO $ threadDelay 1000000 
    put (next env currState)
    animate

-- animate env state = clearScreen >> putStr (drawState env state) >> threadDelay 1000000 >> animate env (next env state)

clearScreen :: IO ()
clearScreen = putStr "\ESC[3J\ESC[1;1H"

