#!/usr/bin/env bash

function configure_git_init() {
    task_setup "configure_git" "Configuring GIT" "Configure git user and email"
}

function configure_git_run() {
    if ! [ -f git/gitconfig.symlink ]
    then
        git_credential='cache'
        if [ "$(uname -s)" == "Darwin" ]
        then
            git_credential='osxkeychain'
        fi

        git_authorname=$(enter_variable " - What is your github author name?" "$(whoami)")
        git_authoremail=$(enter_variable " - What is your github author email?" "$(whoami)@gmail.com")

        sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" $DOTFILES_ROOT/git/gitconfig.symlink.example > $DOTFILES_ROOT/git/gitconfig.symlink

    fi
    return ${E_SUCCESS}
}
