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
        sudo apt-get install -y vim python3-dev python3-pip build-essential wget git zsh curl file python-setuptools autoconf automake pkg-config libgtk-3-dev apt-transport-https ca-certificates software-properties-common
        sudo pip3 install thefuck
    elif [ "$PLATFORM" = "centos" ]; then
        sudo zypper in -y gcc gcc-c++ make openssl-devel wget git curl file python-setuptools autoconf automake pkgconfig python3 python3-devel
        sudo pip install thefuck
    elif [ "$PLATFORM" = "arch" ]; then
        sudo pacman -S thefuck
    elif [ "$PLATFORM" = "darwin" ]; then
        log_info "macOS have existing dependencies we can work with"
    fi
    return ${E_SUCCESS}
}
