module System.URI.Handler.Types (
  UriHandlerInfo(..),
  IconSpec(..), iconFromPath
) where

-- | All the information needed to register an URI handler.
data UriHandlerInfo = UriHandlerInfo
  { uriHandlerPath :: Maybe FilePath  -- ^ Path to the executable to invoke. Omit to use current executable.
  , uriHandlerArgs :: [String]        -- ^ Command-line arguments that the handler should
                                      --   receive when invoked with an URI. The URI will be
                                      --   appended to the end of the command line.
  , uriHandlerName :: String          -- ^ The URI handler's name, and the URI scheme to register as.
  , uriHandlerDesc :: Maybe String    -- ^ A short description for the URI handler. Optional.
  , uriHandlerIcon :: Maybe IconSpec  -- ^ An icon to associate with this URI scheme.
  } deriving (Show, Eq)

-- | Specifies an URI scheme's icon.
data IconSpec = IconSpec
  { iconPath  :: FilePath             -- ^ The path to the file containing the icon.
  , iconIndex :: Int                  -- ^ Index of the icon within the file.
  } deriving (Show, Eq)

-- | Constructor for 'IconSpec' that sets the icon index to 0.
iconFromPath :: FilePath -> IconSpec
iconFromPath path = IconSpec path 0

