#!/bin/sh

RELEASE_NAME=`lsb_release -cs`

# Needed for key verification and initial install.
sudo apt-get install -y apt-transport-https ca-certificates \
                        curl software-properties-common

# Google repos.
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# Docker repo.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $RELEASE_NAME stable"

# Oracle Java.
sudo add-apt-repository -y ppa:webupd8team/java

sudo apt-get update
sudo apt-get install -y aptitude

# Environment.
sudo aptitude install -y \
  alsa-utils \
  gnome-panel \
  gnome-session-flashback \
  lightdm \
  xmonad \
  xorg \

# Essentials
sudo aptitude install -y \
  google-chrome-beta \
  rxvt-unicode \
  stow \
  vim \

# System
sudo aptitude install -y \
  exfat-fuse \
  exfat-utils \
  fio \
  glances \
  go-mtpfs \
  gparted \
  htop \
  ioping \
  iotop \
  parallel \
  pmount \

# Power management
sudo aptitude install -y \
  acpi \
  acpi-support \
  acpi-call-dkms \
  powertop \
  tlp \
  tlp-rdw \
  tp-smapi-dkms \

# Network stuff.
sudo aptitude install -y \
  arp-scan \
  ethtool \
  hping3 \
  kismet \
  kismet-plugins \
  nmap \
  speedtest-cli \
  ssmtp \
  tsocks \
  whois \
  wireless-tools \
  wireshark-gtk \

# Utils.
sudo aptitude install -y \
  clipit \
  cmatrix \
  evince \
  geeqie \
  lbzip2 \
  maim \
  pavucontrol \
  pdftk \
  pigz \
  pxz \
  qbittorrent \
  redshift-gtk \
  texlive-extra-utils \
  tmux \
  xbacklight \
  xclip \
  youtube-dl \

# Dev stuff.
sudo aptitude install -y \
  ack-grep \
  build-essential \
  cabal-install \
  ccache \
  clang \
  cmake \
  docker-ce \
  gdb \
  ghc \
  git \
  git-gui \
  graphviz \
  jq \
  meld \
  openjdk-8-jdk \
  python-pip \
  ruby \
  source-highlight \
  upx \
  vim-gtk \
  vim-youcompleteme \
  zeal \

# Datascience stuff.
sudo aptitude install -y \
  ipython \
  ipython-notebook \
  octave \
  python-matplotlib \
  python-numpy \
  python-pandas \
  python-scipy \
  python-sympy \

# Media.
sudo aptitude install -y \
  clementine \
  lame \
  mplayer \
  mpv \

# Communication
sudo aptitude install -y \
  google-talkplugin \
  telegram-desktop \


# Godeb.
sudo bash -c 'curl https://godeb.s3.amazonaws.com/godeb-amd64.tar.gz | tar xzO > /usr/local/bin/godeb; chmod 755 /usr/local/bin/godeb'

# Install the xsession option.
sudo bash -c 'wget -O/usr/share/xsessions/xsession.desktop http://uone.lambda.space/~fwd/xsession.desktop'

# Vim stuff.
mkdir -p ~/.vim/bak
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Slack client.
curl -s https://packagecloud.io/install/repositories/slacktechnologies/slack/script.deb.sh.deb | sudo bash

# Boot-repair.
sudo add-apt-repository -y ppa:yannubuntu/boot-repair
sudo aptitude update
sudo aptitude install -y boot-repair

# Tor
sudo sh -c "echo deb http://deb.torproject.org/torproject.org $RELEASE_NAME main > /etc/apt/sources.list.d/tor.list"
gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
sudo add-apt-repository -y ppa:webupd8team/tor-browser
sudo aptitude update
sudo aptitude install -y tor-browser

# Kindlegen.
wget -c http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz -O /tmp/k.tar.gz && \
    sudo tar xzf /tmp/k.tar.gz -C /usr/local/bin/ kindlegen && rm -rf /tmp/k.tar.gz
