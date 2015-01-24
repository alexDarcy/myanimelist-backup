module Main where

import System.Environment
import Text.XML.HXT.Core


data Anime = Anime {
  title :: String,
  status :: String
} deriving Show

type AnimeList = [Anime]
  
xpAnime :: PU Anime
xpAnime 
  = xpElem "anime" $ 
  xpFilterCont (hasName "series_title" 
                <+> hasName "my_status") $ 
  xpWrap ( uncurry Anime
         , \s ->  (title s, status s)
         ) $
  xpPair ( xpElem "series_title" $ xpText )
         ( xpElem "my_status" $ xpText)

xpAnimeList :: PU AnimeList
xpAnimeList 
  = xpElem "myanimelist" $ 
  xpFilterCont (hasName "anime") $ 
  xpList $ xpAnime 


main :: IO ()
main = do
  [src] <- getArgs
  a <- runX  ( xunpickleDocument xpAnimeList [ withRemoveWS yes ] src)
  mapM print a
  return ()

