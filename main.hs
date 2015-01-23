module Main where

import System.Environment
import Text.XML.HXT.Core
-- import Text.XML.HXT.Curl


type Anime = String

-- tinstance XmlPickler Anime
--  where xpickle = xpAnime
  
xpAnime :: PU Anime
xpAnime 
  = xpElem "title" $ xpText

main :: IO ()
main = do
  [src] <- getArgs
  runX  (xunpickleDocument xpAnime [] src)
  return ()

