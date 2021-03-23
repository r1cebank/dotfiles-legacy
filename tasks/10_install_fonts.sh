#!/usr/bin/env bash

function install_fonts_init() {
    task_setup "install_fonts" "Install fonts" "Install fonts" "check_system"
}

function install_fonts_run() {
    PLATFORM=$(settings_get "PLATFORM")
    HOST_TYPE=$(settings_get "HOST_TYPE")
    if [ "$HOST_TYPE" = "desktop" ]; then
        if [ "$PLATFORM" = "debian" ]; then
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
            log_info "Installing system fonts."
            while read in; do yay -S "$in" --noconfirm; done < $DOTFILES_ROOT/system/fonts.arch.list
        fi
    fi
    return ${E_SUCCESS}
}
