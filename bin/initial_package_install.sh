#!/bin/bash

RELEASE_NAME=`lsb_release -cs`

P="$HOME/.config/init"
if [ ! -d $P ]; then
  mkdir -p $P
  echo 'First time install.'
fi

# Needed for key verification and initial install.
#sudo apt update

mkdir ~/.ssh/sockets

try() {
  phase=$1
  shift
  cmd=$*

  #echo $cmd
  if [ ! -f $P/$phase ]; then
    tput bold; tput setaf 045
    echo "$phase starting."
    tput sgr0


    if eval "$cmd"; then
      touch $P/$phase
      tput bold; tput setaf 033
      echo "$phase success."
    else
      tput bold; tput setaf 011
      echo "$phase fail."
    fi
  else
    tput bold; tput setaf 207
    echo "$phase already processed."
  fi
  tput sgr0
}

try '00init' \
sudo apt install -y apt-transport-https ca-certificates \
                    curl wget software-properties-common aptitude

# Google repos.
try '01google' $(cat << EOM
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -;
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'
EOM
)

#if [ -e /etc/apt/sources.list.d/google.list ]; then \
#  sudo rm /etc/apt/sources.list.d/google.list; \
#fi

# Docker repo.
try '02docker' $(cat << EOM
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $RELEASE_NAME stable"
EOM
)

# Oracle Java.
#sudo add-apt-repository -y ppa:webupd8team/java

sudo apt update

# Environment.
try '03env' \
sudo apt install -y \
  alsa-utils \
  breeze-cursor-theme \
  gdm3 \
  gnome-panel \
  gnome-screensaver \
  gnome-session-flashback \
  xmonad \
  xorg \

# Install the xsession option.
try '04xsession' $(cat <<E
sudo bash -c 'wget -O/usr/share/xsessions/xsession.desktop https://raw.githubusercontent.com/forwidur/systemconfigs/master/usr/share/xsessions/xsession.desktop'
E
)

# Hook up the local .bashrc.
try '05bashrc' \
echo "source /home/${USER}/.bashrc.fwd" \>\> "/home/${USER}/.bashrc"


# Essentials
try '06essentials' \
sudo apt install -y \
  google-chrome-beta \
  rxvt-unicode \
  stow \
  vim \
  python3 \

# System
try '07system' \
sudo apt install -y \
  exfatprogs \
  fio \
  glances \
  go-mtpfs \
  gparted \
  htop \
  inotify-tools \
  ioping \
  iotop \
  parallel \
  pmount \
  rlwrap \
\&\& \
sudo pip3 install pyudev

# Power management
try '08power' \
sudo apt install -y \
  acpi \
  acpi-support \
  acpi-call-dkms \
  i7z \
  powertop \
  tlp \
  tlp-rdw \
  tp-smapi-dkms \
\&\& \
sudo pip3 install undervolt

# Network stuff.
try '09network' \
sudo apt install -y \
  aircrack-ng \
  arp-scan \
  ethtool \
  hashcat \
  hcxdumptool \
  hcxtools \
  hping3 \
  iperf3 \
  nmap \
  reaver \
  speedtest-cli \
  ssmtp \
  tsocks \
  whois \
  wireless-tools \
  wireguard \
  wireguard-tools \
  wireshark-gtk \

# Utils.
try '10utils' \
sudo apt install -y \
  cmatrix \
  dunst \
  evince \
  flameshot \
  geeqie \
  gnome-sushi \
  lbzip2 \
  maim \
  moreutils \
  rename \
  renameutils \
  pavucontrol \
  pigz \
  pixz \
  qbittorrent \
  parcellite \
  redshift-gtk \
  texlive-extra-utils \
  tmux \
  xbacklight \
  xclip \
  youtube-dl \

# Dev stuff.
try '11dev' \
sudo apt install -y \
  ack \
  build-essential \
  cabal-install \
  ccache \
  clang \
  cmake \
  docker \
  gdb \
  ghc \
  git \
  git-gui \
  graphviz \
  jq \
  meld \
  openjdk-8-jdk \
  python3 \
  python3-pip \
  ruby \
  shellcheck \
  source-highlight \
  upx \
  vim-gtk \
  virt-manager \
  zeal \

# Datascience stuff.
try '12datascience' \
sudo pip3 install \
  argcomplete \
  jupyter \
  jupyterthemes \
  matplotlib \
  numpy \
  pandas \
  scipy \
  seaborn \
  sympy \
  torch \
  vitualenv \
  opencv-python \
\&\& \
sudo apt install -y \
  python3-venv \
  octave \

# Media.
try '13media' \
sudo apt install -y \
  clementine \
  flac \
  lame \
  mpv \

# Communication
try '14comm' \
sudo apt install -y \
  fonts-emojione \
  telegram-desktop \

# Veracrypt
try '15veracrypt' \
sudo add-apt-repository -y ppa:unit193/encryption \&\& \
sudo apt install -y veracrypt

# Snaps
try '16misc_snaps' \
sudo snap install slack --classic \&\& \
sudo snap install simplenote \&\& \
sudo snap install pdftk
#sudo snap install code --classic

# Godeb.
try '17godeb' $(cat <<E
sudo bash -c 'curl https://godeb.s3.amazonaws.com/godeb-amd64.tar.gz | tar xzO > /usr/local/bin/godeb; chmod 755 /usr/local/bin/godeb'
E
)

# Vim stuff.
try '18vim' $(cat << E
mkdir -p ~/.vim/bak;
if [ ! -d "~/.vim/bundle/Vundle" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim;
  vim +PluginInstall +qall;
fi
E
)

# Tor
#sudo sh -c "echo deb http://deb.torproject.org/torproject.org $RELEASE_NAME main > /etc/apt/sources.list.d/tor.list"
#gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
#gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
#sudo add-apt-repository -y ppa:webupd8team/tor-browser
#sudo apt update
#sudo apt install -y tor-browser

# Kindlegen.
#try '19kindlegen' \
#wget -c http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz -O /tmp/k.tar.gz && \
#    sudo tar xzf /tmp/k.tar.gz -C /usr/local/bin/ kindlegen && rm -rf /tmp/k.tar.gz

# gcloud
#export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
export CLOUD_SDK_REPO='cloud-sdk'
try '20gcloud' $(cat << E
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list &&
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - &&
sudo apt update &&
sudo apt install -y google-cloud-sdk kubectl &&
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/ &&
curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 && chmod +x docker-machine-driver-kvm2 && sudo mv docker-machine-driver-kvm2 /usr/local/bin/ &&
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | sudo bash
E
)

# Signal
try '21signal' $(cat << E
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -;
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-xenial.list;
sudo apt update;
sudo apt install signal-desktop;
E
)
