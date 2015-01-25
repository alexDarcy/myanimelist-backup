{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

import System.Environment
import Text.XML.HXT.Core
import Data.Aeson
import Data.Aeson.Encode.Pretty
import GHC.Generics
import qualified Data.ByteString.Lazy as B
import Data.Monoid
import Data.Ord
import qualified Data.Text as T

-- A very simple structure for the anime
data Anime = Anime {
  title :: String,
  status :: String
} deriving (Show, Generic)

type AnimeList = [Anime]

-- Create JSON type automatically
instance ToJSON Anime 

-- Picklers, needed to read from XML
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

-- Pretty printing for output JSON : fields are sorted by keys
comp :: T.Text -> T.Text -> Ordering
comp = keyOrder ["foo","bar"] `mappend` comparing T.length

myConfig = Config {confIndent = 2, confCompare = comp}

main :: IO ()
main = do
  [src] <- getArgs
  [a] <- runX  ( xunpickleDocument xpAnimeList [ withRemoveWS yes ] src)
  let file = "anime.json"
  writeFile file "var data ="
  B.appendFile file $ encodePretty' myConfig a
  appendFile file ";"
  return ()

