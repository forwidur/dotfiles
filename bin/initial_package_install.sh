#!/bin/sh

# Adds Google repos.
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

sudo apt-get update
sudo apt-get install -y aptitude

# Essentials
sudo aptitude install -y \
  gnome-panel \
  google-chrome-beta \
  rxvt-unicode \
  stow \
  vim \
  xmonad \

# Utils.
sudo aptitude install -y \
  clipit \
  geeqie \
  google-talkplugin \
  glances \
  htop \
  qbittorrent \
  tmux \
  xclip \
  youtube-dl \

# Dev stuff.
sudo aptitude install -y \
  build-essential \
  clang \
  cmake \
  ghc \
  git \
  git-gui \
  jq \
  meld \
  source-highlight \
  octave \
  openjdk-8-jdk \
  python-pip \
  ruby \
  vim-gtk \
  vim-youcompleteme \

# Media.
sudo aptitude install -y \
  clementine \
  mplayer2 \


# Misc.
sudo pip install speedtest-cli
curl -sSL https://get.docker.io/ubuntu/ | sudo sh  # Docker.
sudo bash -c 'curl https://godeb.s3.amazonaws.com/godeb-amd64.tar.gz | tar xzO > /usr/local/bin/godeb; chmod 755 /usr/local/bin/godeb' # Godeb.

# Install the xsession option.
sudo bash -c 'wget -O/usr/share/xsessions/xsession.desktop http://uone.cu.cc/~fwd/xsession.desktop'

# Vim stuff.
mkdir -p ~/.vim/bak
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
