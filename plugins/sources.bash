#!/bin/bash
# rainbow mode
git clone git://git.naquadah.org/rainbow.git

# google maps
git clone git://git.naquadah.org/google-maps.git

# magit 
git clone git://github.com/magit/magit.git

# Current color theme
git clone git://github.com/yhvh/color-theme-gnome-3-adwaita.git

# Color theme mode
wget http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz
tar xzf color-theme-6.6.0.tar.gz
mv color-theme-6.6.0/ color-theme
rm color-theme-6.6.0.tar.gz

# haskell mode from http://projects.haskell.org/haskellmode-emacs/
wget http://projects.haskell.org/haskellmode-emacs/haskell-mode-2.8.0.tar.gz
tar xzf haskell-mode-2.8.0.tar.gz
rm haskell-mode-2.8.0.tar.gz
# or
# darcs get http://code.haskell.org/haskellmode-emacs/
