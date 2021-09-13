#!/usr/bin/env bash

function link_dotfile_init() {
    task_setup "link_dotfile" "Link Dotfiles" "Link dotfiles" "check_system"
}

function link_dotfile_run() {
    for src in $(find $DOTFILES_ROOT -maxdepth 1 -mindepth 1 -type d -not -path '.*')
    do
        # link using stow
        log_info "Installing dotfile for $(basename $src)"
        # check and run prelink script
        if [ -f "$src/pre.sh" ]; then
            log_info "Running prelink script for $(basename $src)"
            bash "$src/pre.sh"
        fi
        # check for stow directory
        if [ -d "$src/stow" ]; then
            log_info "Running stow for $(basename $src)"
            stow $src/stow
        fi
        # check and run postlink script
        if [ -f "$src/post.sh" ]; then
            log_info "Running postlink script for $(basename $src)"
            bash "$src/post.sh"
        fi
    done
}
