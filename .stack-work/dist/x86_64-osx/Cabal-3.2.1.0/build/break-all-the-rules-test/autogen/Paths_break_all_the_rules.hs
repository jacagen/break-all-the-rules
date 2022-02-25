{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_break_all_the_rules (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/jamie/Development/break-all-the-rules/.stack-work/install/x86_64-osx/51807da34ea54276b0cc68a7ea83d1818b5b62a3affc2325735b7d2e3022b2b7/8.10.7/bin"
libdir     = "/Users/jamie/Development/break-all-the-rules/.stack-work/install/x86_64-osx/51807da34ea54276b0cc68a7ea83d1818b5b62a3affc2325735b7d2e3022b2b7/8.10.7/lib/x86_64-osx-ghc-8.10.7/break-all-the-rules-0.1.0.0-6d3IDnH2r3UALuiqwWy16H-break-all-the-rules-test"
dynlibdir  = "/Users/jamie/Development/break-all-the-rules/.stack-work/install/x86_64-osx/51807da34ea54276b0cc68a7ea83d1818b5b62a3affc2325735b7d2e3022b2b7/8.10.7/lib/x86_64-osx-ghc-8.10.7"
datadir    = "/Users/jamie/Development/break-all-the-rules/.stack-work/install/x86_64-osx/51807da34ea54276b0cc68a7ea83d1818b5b62a3affc2325735b7d2e3022b2b7/8.10.7/share/x86_64-osx-ghc-8.10.7/break-all-the-rules-0.1.0.0"
libexecdir = "/Users/jamie/Development/break-all-the-rules/.stack-work/install/x86_64-osx/51807da34ea54276b0cc68a7ea83d1818b5b62a3affc2325735b7d2e3022b2b7/8.10.7/libexec/x86_64-osx-ghc-8.10.7/break-all-the-rules-0.1.0.0"
sysconfdir = "/Users/jamie/Development/break-all-the-rules/.stack-work/install/x86_64-osx/51807da34ea54276b0cc68a7ea83d1818b5b62a3affc2325735b7d2e3022b2b7/8.10.7/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "break_all_the_rules_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "break_all_the_rules_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "break_all_the_rules_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "break_all_the_rules_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "break_all_the_rules_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "break_all_the_rules_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
