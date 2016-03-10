#!/bin/bash
#
# Brew packages for OS X setup.
#

if [ "$PLATFORM" = "darwin" ]
then

  # Install homebrew cask addon
  brew install caskroom/cask/brew-cask

  # Install GNU core
  brew tap homebrew/dupes
  brew install coreutils --with-default-names
  brew install findutils --with-default-names
  brew install gnu-indent --with-default-names
  brew install gnu-sed --with-default-names
  brew install gnutls --with-default-names
  brew install grep --with-default-names
  brew install gnu-tar --with-default-names
  brew install gawk

  # Install other CLI utilities
  brew install zsh
  brew install git
  brew install heroku-toolbelt
  brew install redis
  brew install direnv
  brew install argon/mas/mas

  # Install OS X applications
  brew cask install atom
  brew cask install dropbox
  brew cask install google-chrome
  brew cask install caffeine
  brew cask install iterm2
  brew cask install vlc

  # Font management
  brew tap caskroom/fonts
  brew cask install font-input
  brew cask install font-open-sans
  brew cask install font-roboto
  brew cask install font-roboto-slab

fi
