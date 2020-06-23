#!/usr/bin/env bash

function configure_kryptonite_init() {
    task_setup "configure_kryptonite" "Configure kryptonite" "Configure kryptonite on the system" "check_system"
}

function configure_kryptonite_run() {
    PLATFORM=$(settings_get "PLATFORM")
    # Check for Homebrew
    if ! hash kr >/dev/null 2>&1; then
        log_info "Installing Kryptonite for you."

        # Install the correct homebrew for each OS type
        if [ "$PLATFORM" = "debian" ]; then
            curl https://krypt.co/kr | sh
        elif [ "$PLATFORM" = "arch" ]; then
            yay -S kr-bin --noconfirm
        fi
        kr pair
    else
        log_info "Kryptonite is already installed"
        kr pair
    fi
    return ${E_SUCCESS}
}
