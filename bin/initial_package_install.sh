#!/bin/sh

sudo apt-get update
sudo apt-get install -y aptitude

sudo aptitude install -y \
  build-essentials \
  clipit \
  ghc \
  source-highlight \
  qbittorrent \
  xmonad \
  rxvt-unicode \
  vim \
  vim-gtk \
  vim-youcompleteme \
  youtube-dl \

