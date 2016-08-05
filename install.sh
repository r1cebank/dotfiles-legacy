#!/bin/bash
#
# Sets up the machine with essential utilities and bootstraps the dotfiles.

#
# Clone/pull the r1cebank/dotfiles
if [[ -d $HOME/.dotfiles ]]
then
    ( cd $HOME/.dotfiles; git pull; )
else
    git clone https://github.com/r1cebank/dotfiles ~/.dotfiles
fi

cd $HOME/.dotfiles;
installer;
