{-# LANGUAGE RecordWildCards #-}
-- | Small utility program to register any application as a URI handler.
-- This is used by the @register-uri-handler@ executable, but exposed as part
-- of the library for convenience.
module System.URI.Handler.StandaloneRegister (mainRegister) where

import           Data.Semigroup      ((<>))

import           Options.Applicative

import           System.URI.Handler

-- | The @register-uri-handler@ executable's @main@ function. Parses a
-- UriHandlerInfo from the command line (using optparse-applicative) and
-- executes it.
mainRegister :: IO ()
mainRegister = do
  hdlInfo <- execParser $ info (parse <**> helper)
    (  fullDesc
    <> progDesc "Register EXE as a URI handler for SCHEME"
    <> header "hs-uri-handler: A platform-agnostic way to register URI handlers.")
  registerURIHandler hdlInfo

parse :: Parser UriHandlerInfo
parse = UriHandlerInfo
  <$> (Just <$> strArgument
      (  metavar "EXE"
      <> help "The executable to invoke."
      ))
  <*> (many $ strArgument
      (  metavar "ARGS"
      <> help "Additional arguments that will be passed to EXE."
      ))
  <*> (strOption
      (  short 'n'
      <> short 's'
      <> long "name"
      <> long "scheme"
      <> metavar "SCHEME"
      <> help "The URI scheme to register a handler for."
      ))
  <*> (orNothing $ strOption
      (  short 'd'
      <> long "desc"
      <> metavar "DESCRIPTION"
      <> help "A short description for the URI handler."
      ))
  <*> (liftA2 IconSpec
      <$> (orNothing $ strOption
          (  long "icon"
          <> metavar "ICON"
          <> help "Path to a file containing an icon to associate with this handler."
          ))
      <*> (Just <$> option auto
          (  long "icon-index"
          <> value 0
          <> help "Index of the icon within ICON."
          )))

orNothing :: Alternative f => f a -> f (Maybe a)
orNothing p = (Just <$> p) <|> pure Nothing
