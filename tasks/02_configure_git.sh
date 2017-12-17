#!/usr/bin/env bash

function configure_git_init() {
    task_setup "configure_git" "Configuring GIT" "Configure git user and email"
}

function configure_git_run() {
    PLATFORM=$(settings_get "PLATFORM")
    if ! [ -f git/gitconfig.symlink ]
    then

        git_authorname=$(enter_variable " - What is your github author name?" "$(whoami)")
        git_authoremail=$(enter_variable " - What is your github author email?" "$(whoami)@gmail.com")
        git_gpgsign=$(enter_variable " - Do you want to enable commit signing? (true, false)" "true")
        git_gpgkey=$(enter_variable " - What is your signingkey?" "$(gpg --list-secret-keys --with-colons 2> /dev/null | grep '^sec:' | cut -d':' -f 5)")

        sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GPGSIGN/$git_gpgsign/g" -e "s/GPGKEY/$git_gpgkey/g" $DOTFILES_ROOT/git/gitconfig.symlink.template > $DOTFILES_ROOT/git/gitconfig.symlink

    fi
    return ${E_SUCCESS}
}
