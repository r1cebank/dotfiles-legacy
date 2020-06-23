#!/usr/bin/env bash

function npm_install_init() {
    task_setup "npm_install" "npm Install" "Install npm dependencies" "install_nodejs"
}

function npm_install_run() {
    # Reload nodejs environment variables
    source $HOME/.dotfiles/nodejs/env.zsh
    # Install frequently used Node.js packages
    npm install --global $(tr '\n' ' ' < $DOTFILES_ROOT/nodejs/packages.list)
    return ${E_SUCCESS}
}
