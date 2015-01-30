#!/bin/sh

sudo apt-get update
sudo apt-get install -y aptitude

sudo aptitude install -y \
  build-essentials \
  clipit \
  ghc \
  source-highlight \
  xmonad \

