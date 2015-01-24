module Main where

import System.Environment
import Text.XML.HXT.Core


type Anime = String
type AnimeList = [Anime]
  
xpAnime :: PU Anime
xpAnime 
  = xpElem "anime" $ 
  xpFilterCont (hasName "series_title") $ 
  xpElem "series_title" $ xpText

xpAnimeList :: PU AnimeList
xpAnimeList 
  = xpElem "myanimelist" $ xpList $ xpAnime 


main :: IO ()
main = do
  [src] <- getArgs
  a <- runX  ( xunpickleDocument xpAnimeList [ withRemoveWS yes ] src)
  mapM print a
  return ()

