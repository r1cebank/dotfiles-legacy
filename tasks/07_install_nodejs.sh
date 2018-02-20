#!/usr/bin/env bash

function install_nodejs_init() {
    task_setup "install_nodejs" "Install Node.js" "Install Node.js using n" "check_system"
}

function install_nodejs_run() {
    PLATFORM=$(settings_get "PLATFORM")
    # Check for n
    if ! type "nvm" > /dev/null; then
        log_info "Installing Node.js via nvm for you."

        # Install n and latest LTS node.js
        curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

        # Reload nodejs environment variables
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


        # Install the last node lts
        nvm install 8
        nvm alias default 8

    else
        log_info "You already have nvm installed"
    fi
    return ${E_SUCCESS}
}
