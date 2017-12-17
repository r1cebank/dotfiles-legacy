#!/usr/bin/env bash

function configure_kryptonite_init() {
    task_setup "configure_kryptonite" "Configure kryptonite" "Configure kryptonite on the system" "install_brew"
}

function configure_kryptonite_run() {
    PLATFORM=$(settings_get "PLATFORM")
    # Check for Homebrew
    if ! type "kr" > /dev/null; then
        log_info "Installing Kryptonite for you."

        # Install the correct homebrew for each OS type
        if [ "$PLATFORM" = "darwin" ]; then
            brew install kryptco/tap/kr
        else
            curl https://krypt.co/kr | sh
        fi
    else
        log_info "Kryptonite is already installed"
    fi
    kr pair
    return ${E_SUCCESS}
}
