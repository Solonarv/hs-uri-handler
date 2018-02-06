{-# LANGUAGE CPP #-}
module System.URI.Handler (
  registerURIHandler,
  module System.URI.Handler
) where

import           System.URI.Handler.Types          as System.URI.Handler

#ifdef mingw32_HOST_OS

import           System.URI.Handler.Windows

#else

import           System.URI.Handler.NotImplemented

#endif
