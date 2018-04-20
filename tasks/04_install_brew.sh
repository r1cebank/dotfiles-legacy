#!/usr/bin/env bash

function install_brew_init() {
    task_setup "install_brew" "Install brew" "Install brew on the system" "check_system"
}

function install_brew_run() {
    PLATFORM=$(settings_get "PLATFORM")
    # Check for Homebrew
    if ! hash brew >/dev/null 2>&1; then
        # Install the correct homebrew for each OS type
        if [ "$PLATFORM" = "darwin" ]; then
            log_info "Installing Homebrew for you."
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        else
            log_info "Linux systems does not require install of homebrew"
        fi
    else
        log_info "Brew is already installed on your system, running update now"
        brew update
    fi
    return ${E_SUCCESS}
}
