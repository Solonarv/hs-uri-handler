module System.URI.Handler.NotImplemented (
  registerURIHandler
) where

import           System.URI.Handler.Types

notImplemented :: String -> a
notImplemented fn = error ("No " ++ fn ++ "implementation for this platform.")

registerURIHandler :: UriHandlerInfo -> IO ()
registerURIHandler _ = notImplemented "registerURIHandler"
