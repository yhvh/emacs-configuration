#!/bin/bash
# emacs build script
tar xzf emacs-24.0.50.tar.gz
rm emacs-24.0.50.tar.gz

cd emacs-24.0.50
# swap in my gnus image
rm etc/images/gnus/gnus.*
cp ~/Pictures/fedora.png etc/images/gnus/gnus.png

setarch i686 ./configure --with-dbus --with-gif --with-jpeg --with-png --with-rsvg --with-tiff --with-xft --with-xpm --with-x-toolkit=gtk
setarch i686 make
