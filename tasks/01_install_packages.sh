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
        curl https://krypt.co/kr | sh
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
    else
        log_info "skipping, not installing system tools"
    fi
    return ${E_SUCCESS}
}
