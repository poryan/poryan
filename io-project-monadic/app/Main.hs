module Main where
import Control.Monad.Trans.Writer (WriterT,runWriterT)

import Control.Monad.State
import Control.Monad.Reader

import Animation.Animate (animate, runApp)
import Animation.CLI (cli)
import Control.Monad.State (evalStateT)
import Control.Monad.Reader (MonadReader(ask))
import qualified Data.Text as T
--import Animation.CLI (cli)

main :: IO ()
main = do

  writeFile "bouncingball.txt" "Starting ball bounce"
  y <- runApp animate
  writeFile "bouncingball.txt" (T.unpack y)
   