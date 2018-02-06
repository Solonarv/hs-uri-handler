module Main where

import           Control.Monad      (when)
import           System.Environment

import           System.URI.Handler

main :: IO ()
main = do
  args <- getArgs
  print args
  _ <- getLine
  when (null args) $ do
    registerURIHandler $ UriHandlerInfo
      { uriHandlerPath = Nothing
      , uriHandlerArgs = ["--uri-handler"]
      , uriHandlerName = "hs-uri-handler-test"
      , uriHandlerDesc = Just "Trivial test for hs-uri-handler"
      , uriHandlerIcon = Nothing
      }
