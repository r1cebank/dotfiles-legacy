#!/usr/bin/env bash

function install_brew_init() {
    task_setup "install_brew" "Install brew" "Install brew on the system" "check_system"
}

function install_brew_run() {
    PLATFORM=$(settings_get "PLATFORM")
    # Check for Homebrew
    if ! type "brew" > /dev/null; then
        log_info "Installing Homebrew for you."

        # Install the correct homebrew for each OS type
        if [ "$PLATFORM" = "darwin" ]; then
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        else
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
        fi
    else
        log_info "Brew is already installed on your system, running update now"
        brew update
    fi
    return ${E_SUCCESS}
}
