#!/bin/bash
#
# Sets up the machine with essential utilities and bootstraps the dotfiles.

# Install gcc, git and zsh if this is Linux
if [ "$PLATFORM" = "debian" ]; then
  sudo apt-get install build-essential git zsh
elif [ "$PLATFORM" = "centos" ]; then
  sudo yum install gcc gcc-c++ make openssl-devel git
fi

#
# # Clone/pull the r1cebank/dotfiles
# if [[ -d $HOME/.dotfiles ]]
# then
#   ( cd $HOME/.dotfiles; git pull; )
# else
#   git clone https://github.com/r1cebank/dotfiles ~/.dotfiles
# fi
#
# # Setup the envar for dotfiles dir
# export ZSH=$HOME/.dotfiles
