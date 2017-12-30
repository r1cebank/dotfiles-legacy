#!/usr/bin/env bash

function install_tools_init() {
    task_setup "install_tools" "Install Tools" "Install essential toolbelts"
}

function install_tools_run() {
    PLATFORM=$(settings_get "PLATFORM")
    if [ "$PLATFORM" = "darwin" ]; then

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
        brew install direnv
        brew install wget

        # Install OS X applications
        brew cask install dropbox
        brew cask install google-chrome
        brew cask install caffeine
        brew cask install iterm2
        brew cask install vlc
        brew cask install go2shell
        brew cask install diskmaker-x
        brew cask install appcleaner
        brew cask install visual-studio-code
        brew cask install steam
        brew cask install mplayerx
        brew cask install sketch
        brew cask install macdown
        brew cask install kaleidoscope

        # Font management
        brew tap caskroom/fonts
        brew cask install font-input
        brew cask install font-open-sans
        brew cask install font-roboto
        brew cask install font-roboto-slab
    elif [ "$PLATFORM" = "debian" ]; then
        # Adding chrome
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
        sudo apt-get update
        sudo apt-get install -y google-chrome-stable
        sudo apt-get install -f -y
        # Adding vscode
        curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
        sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
        sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
        sudo apt-get update
        sudo apt-get install code
        # intall steam
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F24AEA9FB05498B7
        REPO="deb http://repo.steampowered.com/steam/ $(lsb_release -cs) steam"
        echo "${REPO}" > /tmp/steam.list
        sudo mv /tmp/steam.list /etc/apt/sources.list.d/ && \
        sudo apt-get update
        sudo apt-get install -y steam

        # install java
        sudo apt-get install -y openjdk-8-jdk

    elif [ "$PLATFORM" = "centos" ]; then
        # Ading vscode
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
        yum check-update
        sudo yum install -y code

    fi
    return ${E_SUCCESS}
}
