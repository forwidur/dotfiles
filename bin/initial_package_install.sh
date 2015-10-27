#!/bin/sh

# Adds Google repos.
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

sudo apt-get update
sudo apt-get install -y aptitude

# Essentials
sudo aptitude install -y \
  xmonad \
  rxvt-unicode \

# Utils.
sudo aptitude install -y \
  clipit \
  qbittorrent \
  youtube-dl \

# Dev stuff.
sudo aptitude install -y \
  build-essentials \
  clang \
  ghc \
  gcc \
  git \
  git-gui \
  google-chrome-beta \
  google-talkplugin \
  meld \
  source-highlight \
  octave \
  vim \
  vim-gtk \
  vim-youcompleteme \

# Media.
sudo aptitude install -y \
  clementine \
  mplayer2 \

