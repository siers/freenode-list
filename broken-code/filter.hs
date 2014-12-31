{-# LANGUAGE OverloadedStrings, NoImplicitPrelude #-}

import Control.Category
import Control.Monad
import Data.Monoid
import Data.Functor
import Data.String
import System.IO (print, getContents)
import Text.Regex.TDFA

-- From http://stackoverflow.com/questions/4953301/match-irc-channel-with-regular-expression
-- /([#&][^\x07\x2C\s]{,200})/
-- Should do it, according to RFC1459's specification.
-- by http://stackoverflow.com/users/298053/brad-christie

regex :: String
regex =
    "ijsdataminer\\d+ " `mappend`          -- nick$RANDOM
    "([#&][^\x07\x2C\\s]{,200})" `mappend` -- channel's regex(captured)
    "(\\d+)\\): " `mappend`                -- user count(captured) + format
    "(.*)"                                 -- channel's topic(captured)

channels :: String -> [(String, String, String)]
channels = fmap (\(_:a:b:c:_) -> (a, b, c)) . (=~ regex)

main = getContents >>= mapM_ print . channels
