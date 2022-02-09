module Main where
import Control.Monad.Trans.Writer (WriterT,runWriterT)
import qualified Data.Text as T
import Control.Monad.State
import Control.Monad.Reader

import Animation.Animate (animate)
import Animation.CLI (cli)
import Control.Monad.State (evalStateT)

--import Animation.Animate (animate)
--import Animation.CLI (cli)

main :: IO ()


--type AppM a = WriterT T.Text (StateT s (ReaderT env IO)) a
--runApp :: AppM () -> IO T.Text

--main = cli >>= (\(env, state) -> animate env state)

main = do
  -- do some cli parsing
    (env, state) <- cli
    --runReaderT (runStateT animate state) env
    x <-runReaderT (runStateT (runWriterT animate) state) env
    return ()
  --  animate env
  -- logs <- runApp animationApp
  -- write the logs to a file called log.txt