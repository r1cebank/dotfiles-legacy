#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if [[ $(uname) == 'Darwin' ]]
then

if test ! $(which brew)
then
  echo "  Installing Homebrew for you."

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
  fi

fi

  # Install homebrew cask addon
  brew install caskroom/cask/brew-cask

  # Install GNU CLI utilities
  brew install gnu-sed --with-default-names
  brew install zsh
  brew install git
  brew install heroku-toolbelt
  brew install redis

  # Install OS X applications
  brew cask install atom
  brew cask install dropbox
  brew cask install google-chrome
  brew cask install flux
  brew cask install caffeine
  brew cask install iterm2

  # Font management
  brew tap caskroom/fonts
  brew cask install font-input
  brew cask install font-open-sans
  brew cask install font-roboto
  brew cask install font-roboto-slab

fi

exit 0
