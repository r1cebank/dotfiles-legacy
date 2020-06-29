#!/usr/bin/env bash

function configure_git_init() {
    task_setup "configure_git" "Configuring GIT" "Configure git user and email" "check_system"
}

function configure_git_run() {
    PLATFORM=$(settings_get "PLATFORM")
    # Get the auth key
    AUTH_KEY=$(gpg --card-status --with-colons --with-keygrip | grep '^grp:' | cut -d ':' -f 4)
    # Setup gpg keys
    gpg --recv $(gpg --card-status --with-colons 2> /dev/null | grep '^fpr:' | cut -d':' -f 2)
    # Here we need to trust the key
    gpg --edit-key $(gpg --card-status --with-colons 2> /dev/null | grep '^fpr:' | cut -d':' -f 2)
    # List the smart card status
    gpg --card-status
    if ! [ -f git/gitconfig.symlink ]
    then

        git_authorname=$(enter_variable " - What is your github author name?" "$(whoami)")
        git_authoremail=$(enter_variable " - What is your github author email?" "$(whoami)@gmail.com")
        git_gpgsign=$(enter_variable " - Do you want to enable commit signing? (true, false)" "true")
        git_gpgkey=$(enter_variable " - What is your signingkey?" "$(gpg --list-secret-keys --with-colons 2> /dev/null | grep '^sec:' | cut -d':' -f 5)")

        sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GPGSIGN/$git_gpgsign/g" -e "s/GPGKEY/$git_gpgkey/g" $DOTFILES_ROOT/git/gitconfig.symlink.template > $DOTFILES_ROOT/git/gitconfig.symlink

    fi

    # Setup gpg-agent
    echo $AUTH_KEY >> $HOME/.gnupg/sshcontrol
    echo "enable-ssh-support" >> $HOME/.gnupg/gpg-agent.conf
    gpgconf --launch gpg-agent
    return ${E_SUCCESS}
}
