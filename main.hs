--module Main where
{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

import System.Environment
import Text.XML.HXT.Core
import Data.Aeson
import GHC.Generics
import qualified Data.ByteString.Lazy as B

data Anime = Anime {
  title :: String,
  status :: String
} deriving (Show, Generic)

instance ToJSON Anime 

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
  [a] <- runX  ( xunpickleDocument xpAnimeList [ withRemoveWS yes ] src)
  -- mapM (print . encode) a
  let b = encode ( a !! 0 )
  B.writeFile "myfile.json" b
  return ()

