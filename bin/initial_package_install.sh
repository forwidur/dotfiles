#!/bin/sh

# Adds Google repos.
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# Docker repo.
sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RELEASE_NAME=`lsb_release -cs`
sudo bash -c "echo deb https://apt.dockerproject.org/repo ubuntu-${RELEASE_NAME} main > /etc/apt/sources.list.d/docker.list"

# Oracle Java.
sudo add-apt-repository -y ppa:webupd8team/java

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
  fio \
  geeqie \
  glances \
  google-talkplugin \
  gparted \
  htop \
  ioping \
  iotop \
  lame \
  pmount \
  powertop \
  qbittorrent \
  texlive-extra-utils \
  tmux \
  xbacklight \
  xclip \
  youtube-dl \

# Dev stuff.
sudo aptitude install -y \
  ack-grep \
  build-essential \
  clang \
  cmake \
  docker-engine \
  ghc \
  git \
  git-gui \
  jq \
  meld \
  octave \
  openjdk-8-jdk \
  python-pip \
  ruby \
  source-highlight \
  upx \
  vim-gtk \
  vim-youcompleteme \
  zeal \

# Media.
sudo aptitude install -y \
  clementine \
  mplayer \

# Power management
sudo aptitude install -y \
  acpi-call-dkms \
  tlp \
  tlp-rdw \
  tp-smapi-dkms \


# Misc.
sudo pip install -y speedtest-cli
sudo bash -c 'curl https://godeb.s3.amazonaws.com/godeb-amd64.tar.gz | tar xzO > /usr/local/bin/godeb; chmod 755 /usr/local/bin/godeb' # Godeb.

# Install the xsession option.
sudo bash -c 'wget -O/usr/share/xsessions/xsession.desktop http://uone.cu.cc/~fwd/xsession.desktop'

# Vim stuff.
mkdir -p ~/.vim/bak
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Slack client.
sudo apt-add-repository -y ppa:rael-gc/scudcloud
sudo aptitude update
sudo aptitude install -y scudcloud

# Telegram client.
sudo add-apt-repository ppa:atareao/telegram
sudo aptitude update
sudo aptitude install -y telegram
