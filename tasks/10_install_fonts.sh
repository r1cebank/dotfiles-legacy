#!/usr/bin/env bash

function install_fonts_init() {
    task_setup "install_fonts" "Install fonts" "Install fonts" "check_system"
}

function install_fonts_run() {
    PLATFORM=$(settings_get "PLATFORM")
    HOST_TYPE=$(settings_get "HOST_TYPE")
    if [ "$HOST_TYPE" = "desktop" ]; then
        if [ "$PLATFORM" = "arch" ]; then
            log_info "Installing fonts from package."
            while read in; do yay -S "$in" --noconfirm; done < $DOTFILES_ROOT/system/fonts.arch.list
            
            log_info "Installing fonts from file."
            cp -R $DOTFILES_ROOT/fonts/* $HOME/.local/share/fonts
            fc-cache -f -v
        fi
    fi
    return ${E_SUCCESS}
}
