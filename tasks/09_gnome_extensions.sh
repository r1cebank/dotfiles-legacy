#!/usr/bin/env bash

function gnome_extensions_init() {
    task_setup "gnome_extensions" "Gnome Extensions" "Install gnome extensions" "install_tools"
}

function gnome_extensions_run() {
    # Check for gnome
    mkdir -p $HOME/.local/share/gnome-shell/extensions
    if hash gnome-shell >/dev/null 2>&1; then
        log_info "Installing gnome extensions."
        while read in; do $DOTFILES_ROOT/bin/gnome-ext-install install "$in"; done < $DOTFILES_ROOT/gnome/extensions.list
    else
        log_info "Did not find gnome, skipping gnome extensions."
    fi
    gnome-shell --replace &>/dev/null & disown
    return ${E_SUCCESS}
}
