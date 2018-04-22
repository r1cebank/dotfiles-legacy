#!/usr/bin/env bash

function install_fonts_init() {
    task_setup "install_fonts" "Install fonts" "Install fonts"
}

function install_fonts_run() {
    PLATFORM=$(settings_get "PLATFORM")
    if [ "$PLATFORM" = "darwin" ]; then
        log_info "not going to run on OSX"
    elif [ "$PLATFORM" = "debian" ]; then
        mkdir -p $HOME/.fonts
        local overwrite_all=false backup_all=false skip_all=false

        sudo apt-get install fonts-powerline

        for src in $(find -H "$DOTFILES_ROOT/fonts" -maxdepth 2 -name '*.symlink')
        do
            dst="$HOME/.fonts/$(basename "${src%.*}")"
            link_file "$src" "$dst"
        done
        fc-cache -f -v
    elif [ "$PLATFORM" = "arch" ]; then
        yaourt -S ttf-hack --noconfirm
    fi
    return ${E_SUCCESS}
}
