#!/usr/bin/env bash

function code_install_init() {
    task_setup "code_install" "Code Install" "Install code packages" "install_applications"
}

function code_install_run() {
    # Check for code
    if hash code >/dev/null 2>&1; then
        log_info "Installing code extensions."
        while read in; do code --install-extension "$in"; done < $DOTFILES_ROOT/code/extensions.list
    else
        log_info "Did not find code, skipping Code packages."
    fi
    return ${E_SUCCESS}
}
