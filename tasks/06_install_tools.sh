#!/usr/bin/env bash

function install_tools_init() {
    task_setup "install_tools" "Install Tools" "Install essential toolbelts"
}

function install_tools_run() {
    PLATFORM=$(settings_get "PLATFORM")
    if [ "$PLATFORM" = "darwin" ]
    then

        # Install homebrew cask addon
        brew install caskroom/cask/brew-cask

        # Install GNU core
        brew tap homebrew/dupes
        brew install coreutils
        brew install findutils
        brew install gnu-indent
        brew install gnu-sed
        brew install gnutls
        brew install grep
        brew install gnu-tar
        brew install gawk

        # Install other CLI utilities
        brew install zsh
        brew install git
        brew install heroku-toolbelt
        brew install redis
        brew install direnv
        brew install wget
        brew install argon/mas/mas

        # Install OS X applications
        brew cask install atom
        brew cask install dropbox
        brew cask install google-chrome
        brew cask install caffeine
        brew cask install iterm2
        brew cask install vlc
        brew cask install go2shell
        brew cask install diskmaker-x
        brew cask install appcleaner
        brew cask install nylas-n1
        brew cask install skype
        brew cask install visual-studio-code
        brew cask install github-desktop
        brew cask install webstorm
        brew cask install gitkraken
        brew cask install steam
        brew cask install mplayerx
        brew cask install textexpander
        brew cask install sketch
        brew cask install macdown
        brew cask install kaleidoscope

        # Font management
        brew tap caskroom/fonts
        brew cask install font-input
        brew cask install font-open-sans
        brew cask install font-roboto
        brew cask install font-roboto-slab
    fi
    return ${E_SUCCESS}
}
