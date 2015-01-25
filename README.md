# MyAnimeList backup
![Build status](https://travis-ci.org/alexDarcy/myanimelist-backup.svg)

If you want to see locally the list of your anime or manga from
[MyAnimeList.net](http://myanimelist.net), this program is for you.

## Usage
Export your list from the website to the XML format. Then run :

    ./dist/build/myanimelist-backup/mal-backup animelist.xml

This will generate a nicely formatted JSON file containg your anime. You can then see it locally
using the template given in [anime.html](anime.html). An example of the
resulting list [is available here](http://alexdarcy.github.io/myanimelist-backup).

## Compiling
This suppose you have Haskell installed. If that's not the case, see the
[Getting started from the excellent guide by
bitemyapp](https://github.com/bitemyapp/learnhaskell) to configure the system.

This project requires the following Haskell packages :

* aeson
* aeson-pretty
* hxt

You can either install them globally or use a sandbox :

    cabal sandbox init
    cabal install --only-dependencies

Then compile with :

    cabal build

The executable will be `./dist/build/myanimelist-backup/mal-backup`.
