#!/bin/bash
#
# Sets up the machine with essential utilities and bootstraps the dotfiles.

# Install gcc, git and zsh if this is Linux
if [[ $(uname) == 'Linux' ]]
then sudo apt-get install build-essential git zsh; fi

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
