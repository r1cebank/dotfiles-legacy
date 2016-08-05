#!/usr/bin/env bash

function configure_npmrc_init() {
    task_setup "configure_npmrc" "Install npmrc" "Install .npmrc"
}

function configure_npmrc_run() {
    if ! [ -f $DOTFILES_ROOT/nodejs/npmrc.symlink ]
    then
        cp $DOTFILES_ROOT/nodejs/npmrc.symlink.example $DOTFILES_ROOT/nodejs/npmrc.symlink
    fi
    return ${E_SUCCESS}
}
