#!/usr/bin/env runhaskell

{-# LANGUAGE OverloadedStrings #-}

import Turtle

main = do
    cd "/tmp"
    mkdir "test"
    output "test/foo" "Hello, world!"  -- Write "Hello, world!" to "test/foo"
    stdout (input "test/foo")          -- Stream "test/foo" to stdout
    rm "test/foo"
    rmdir "test"
    sleep 1
    die "Urk!"


-- End Game
