module System.URI.Handler.Windows (
  registerURIHandler
) where

import           Control.Exception        (bracket)
import           Data.Maybe
import           System.Environment

import           System.Win32.Registry
import           System.Win32.Types

import           System.URI.Handler.Types

registerURIHandler :: UriHandlerInfo -> IO ()
registerURIHandler info = do
    targetExe <- case (uriHandlerPath info) of
      Just path -> return path
      Nothing   -> getExecutablePath
    withCreateKey hKEY_CLASSES_ROOT (uriHandlerName info) $
      \handlerKey -> do
        regSetStringValue handlerKey "URL Protocol" protocolVal
        withMaybe (uriHandlerDesc info) $ regSetValue handlerKey ""
        withMaybe (uriHandlerIcon info) $
          \icon -> withCreateKey handlerKey "DefaultIcon" $
            \iconKey -> regSetValue iconKey "" (convertIcon icon)
        withCreateKey handlerKey "shell\\open\\command" $
          \cmdKey -> do
            regSetValue cmdKey "" (invokeCommand targetExe)
  where
    protocolVal = fromMaybe ("URL:" ++ uriHandlerName info) (uriHandlerDesc info)
    invokeCommand targetExe =
      concat $ [ "\""
             , targetExe
             , "\""
             ] ++ map (' ':) (uriHandlerArgs info)
               ++ [" \"%1\""]


withCreateKey :: HKEY -> String -> (HKEY -> IO a) -> IO a
withCreateKey parent path act = bracket (regCreateKey parent path) regCloseKey act

withMaybe :: Maybe a -> (a -> IO ()) -> IO ()
withMaybe Nothing _    = return ()
withMaybe (Just a) act = act a

convertIcon :: IconSpec -> String
convertIcon (IconSpec path ix) = path ++ ',' : show ix
