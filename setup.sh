#!/bin/bash
#
# Sets up the machine with essential utilities and bootstraps the dotfiles.

# Platform detection
# Mainly to differentiate between OS X, Ubuntu and CentOS
PLATFORM=$(uname | tr "[:upper:]" "[:lower:]")
if [ "$PLATFORM" = "linux" ]; then
  if type "yum" > /dev/null; then
    PLATFORM="centos"
  fi
  if type "apt-get" > /dev/null; then
    PLATFORM="debian"
  fi
fi

# Install gcc, git and zsh if this is Linux
if [ "$PLATFORM" = "ubuntu" ]; then
  sudo apt-get install build-essential git zsh
elif [ "$PLATFORM" = "centos" ]; then
  sudo yum install gcc gcc-c++ make openssl-devel git
fi

# Clone/pull the jluchiji/dotfiles
if [[ -d $HOME/.dotfiles ]]
then
  ( cd $HOME/.dotfiles; git pull; )
else
  git clone https://github.com/jluchiji/dotfiles ~/.dotfiles
fi

# Setup the envar for dotfiles dir
export ZSH=$HOME/.dotfiles

# Setup the dotfiles
$ZSH/script/bootstrap
$ZSH/script/install
