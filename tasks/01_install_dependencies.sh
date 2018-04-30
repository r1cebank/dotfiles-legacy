#!/usr/bin/env bash

function install_dependencies_init() {
    task_setup "install_dependencies" "Install dependencies" "Install system packages" "check_system"
}

function install_dependencies_run() {
    PLATFORM=$(settings_get "PLATFORM")
    log_info "You are running: $PLATFORM"
    # Install gcc, git and zsh if this is Linux
    if [ "$PLATFORM" = "debian" ]; then
        sudo apt-get update
        sudo apt-get install -y vim python3-dev python3-pip build-essential lib32stdc++6 \
            wget git zsh curl direnv file python-setuptools autoconf automake pkg-config \
            libgtk-3-dev apt-transport-https ca-certificates software-properties-common \
            gnupg2 gnupg-agent pinentry-curses scdaemon pcscd yubikey-personalization libusb-1.0-0-dev
        sudo pip3 install thefuck
    elif [ "$PLATFORM" = "centos" ]; then
        sudo zypper in -y gcc gcc-c++ make openssl-devel wget git curl file python-setuptools autoconf automake pkgconfig python3 python3-devel
        sudo pip install thefuck
    elif [ "$PLATFORM" = "arch" ]; then
        log_info "temporaily increasing /tmp to 10GB"
        sudo mount -o remount,size=10G,noatime /tmp
        log_info "updating existing dependencies..."
        sudo pacman -Syu --noconfirm
        sudo pacman -S --noconfirm --needed base-devel thefuck python3 wget zsh curl
        # Installing yaourt
        git clone https://aur.archlinux.org/package-query.git
        cd package-query
        makepkg -si --noconfirm
        cd ..
        git clone https://aur.archlinux.org/yaourt.git
        cd yaourt
        makepkg -si --noconfirm
        cd ..
        rm -rf package-query
        rm -rf yaourt
        # installing yubikey manager
        sudo yaourt -S yubikey-manager --noconfirm
    elif [ "$PLATFORM" = "darwin" ]; then
        log_info "macOS have existing dependencies we can work with"
    fi
    return ${E_SUCCESS}
}
