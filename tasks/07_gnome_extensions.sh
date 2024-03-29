#!/usr/bin/env bash

function gnome_extensions_init() {
    task_setup "gnome_extensions" "Gnome Extensions" "Install gnome extensions" "install_applications"
}

function gnome_extensions_run() {
    # Check for gnome
    mkdir -p $HOME/.local/share/gnome-shell/extensions
    if hash gnome-shell >/dev/null 2>&1; then
        log_info "Installing gnome extensions."
        while read in; do
            until $DOTFILES_ROOT/bin/gnomex install "$in"
            do
                echo "Try to install $in"
                sleep 2
                xdotool key "Alt+F2+r" && sleep 0.5 && xdotool key "Return"
                sleep 4
            done
        done < $DOTFILES_ROOT/gnome/extensions.list
    else
        log_info "Did not find gnome, skipping gnome extensions."
    fi
    # log_info "Skipping installing gnome extensions"
    return ${E_SUCCESS}
}
