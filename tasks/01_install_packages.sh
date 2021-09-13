#!/usr/bin/env bash

function install_packages_init() {
    task_setup "install_packages" "Install packages" "Install system packages" "check_system"
}

function install_packages_run() {
    PLATFORM=$(settings_get "PLATFORM")
    log_info "You are running: $PLATFORM"
    # Install gcc, git and zsh if this is Linux
    if [ "$PLATFORM" = "debian" ]; then
        sudo apt-get update
        log_info "installing system packages..."
        while read in; do sudo apt-get install -y "$in"; done < $DOTFILES_ROOT/system/packages.debian.list
        sudo pip3 install thefuck
    elif [ "$PLATFORM" = "arch" ]; then
        log_info "temporaily increasing /tmp to 10GB"
        sudo mount -o remount,size=10G,noatime /tmp
        log_info "updating existing dependencies..."
        sudo pacman -Syu --noconfirm
        log_info "installing system packages..."
        while read in; do
            [[ $in == !* ]] && continue
            sudo pacman -S "$in" --needed --noconfirm;
        done < $DOTFILES_ROOT/system/packages.arch.list

        log_info "installing vim plug..."
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

        # enable pcscd service
        sudo systemctl enable pcscd
        sudo systemctl start pcscd

        # enable loop module
        if lsmod | grep loop &> /dev/null; then
            log_info "loop is loaded!"
        else
            log_info "loop is not loaded! Enabling it now"
            sudo tee /etc/modules-load.d/loop.conf <<< "loop"
            sudo modprobe loop
        fi
    else
        log_info "skipping, not installing system tools"
    fi

    # install rust
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # install nodejs
    if ! type "nvm" > /dev/null; then
        log_info "Installing Node.js via nvm for you."

        # Install n and latest LTS node.js
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

        # Reload nodejs environment variables
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


        # Install the last node lts
        nvm install lts/*
        nvm alias default lts/*

    else
        log_info "You already have nvm installed"
    fi
    return ${E_SUCCESS}
}
