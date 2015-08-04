#!/bin/sh
#
# Sets up the machine with essential utilities and bootstraps the dotfiles.

export ZSH=$HOME/.dotfiles

# Install gcc, git and zsh if this is Linux
if [[ $(uname) == 'Linux' ]]
then sudo apt-get install build-essential git zsh; fi

# Setup the dotfiles
$ZSH/script/bootstrap
$ZSH/script/install
