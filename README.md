# MyAnimeList backup
If you want to see locally the list of your anime or manga from
[MyAnimeList.net](http://myanimelist.net), this program is for you.

## Usage
Export your list from the website to the XML format. Then run :

    ./myanimelist animelist.xml

This will generate a nicely formatted JSON file containg your anime. You can then see it locally
using the template here [anime.html](anime.html).

## Compiling
This requires the following Haskell packages :

* aeson
* aeson-pretty
* hxt

Install them using Cabal. You don't know how to do it ? See the [Getting
started from the excellent guide by
bitemyapp](https://github.com/bitemyapp/learnhaskell) to configure the system.
Then read this [nice guide to install
packages](https://www.fpcomplete.com/user/simonmichael/how-to-cabal-install).

Then compile with

    ghc --make MyAnimelist.hs -o myanimelist
