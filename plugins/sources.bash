#!/bin/bash
# rainbow mode
git clone git://git.naquadah.org/rainbow.git

# google maps
git clone git://git.naquadah.org/google-maps.git

# magit 
git clone git://github.com/magit/magit.git

# haskell mode from http://projects.haskell.org/haskellmode-emacs/
wget http://projects.haskell.org/haskellmode-emacs/haskell-mode-2.8.0.tar.gz
tar xzf haskell-mode-2.8.0.tar.gz
rm haskell-mode-2.8.0.tar.gz
# or
# darcs get http://code.haskell.org/haskellmode-emacs/
