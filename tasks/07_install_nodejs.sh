#!/usr/bin/env bash

function install_nodejs_init() {
    task_setup "install_nodejs" "Install Node.js" "Install Node.js using n" "check_system"
}

function install_nodejs_run() {
    PLATFORM=$(settings_get "PLATFORM")
    # Check for n
    if ! type "n" > /dev/null; then
        log_info "Installing Node.js via n for you."

        # Install n and latest LTS node.js
        curl -L http://git.io/n-install | bash -s -- -n -y lts

        # Reload nodejs environment variables
        source $HOME/.dotfiles/nodejs/env.zsh

        # Install the last node lts
        n lts

        # Hide the folder so that it's not visible
        if [ "$PLATFORM" = "darwin" ]; then
            chflags hidden ~/n
        else
            echo "n" >> $HOME/.hidden
        fi
    else
        log_info "You already have n installed"
    fi
    return ${E_SUCCESS}
}
