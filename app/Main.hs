{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Concurrent
import           Z.IO.Buffered
import           Z.IO.StdStream

main :: IO ()
main = do
  withMVar stderrBuf $ \ o -> do
    writeBuffer o "12345\n"
    flushBuffer o
  threadDelay 4000000
