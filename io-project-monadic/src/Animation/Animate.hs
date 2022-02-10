module Animation.Animate where

import Animation.State
import Animation.Draw ( drawState )
import Control.Monad.Reader (ReaderT (runReaderT),liftIO,lift,ask)
import Control.Monad.State(StateT (runStateT),evalStateT,execStateT,get,put)
import Control.Monad.Writer(WriterT (runWriterT),tell,execWriterT, runWriter)
import qualified Data.Text as T

import Control.Concurrent (threadDelay, getChanContents)
import Animation.CLI (cli)

type AppM a = WriterT T.Text (StateT State (ReaderT Env IO)) a

runApp :: AppM () ->  IO T.Text
runApp app = do
                (e, s) <- cli
                c <- runReaderT (runStateT (runWriterT app) s) e
                return (snd (fst c))


animate :: AppM ()
animate = do
    env <- ask
    currState <- get
    tell ( T.pack ("Writing to postion coords " ++ show (position currState) ++ " and direction " ++ show (direction currState)))
    liftIO clearScreen
    liftIO $ putStr (drawState env currState)
    liftIO $ threadDelay 1000000 
    put (next env currState)
    animate


clearScreen :: IO ()
clearScreen = putStr "\ESC[3J\ESC[1;1H"

