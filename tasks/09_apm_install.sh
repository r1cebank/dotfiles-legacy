#!/usr/bin/env bash

function apm_install_init() {
    task_setup "apm_install" "apm Install" "Install atom packages" "install_tools"
}

function apm_install_run() {
    # Check for apm
    if type "apm" > /dev/null; then
        log_info "Installing atom packages."
        apm install $(tr '\n' ' ' < $DOTFILES_ROOT/atom.symlink/packages.list)
    else
        log_info "Did not find apm, skipping Atom packages."
    fi
    return ${E_SUCCESS}
}
