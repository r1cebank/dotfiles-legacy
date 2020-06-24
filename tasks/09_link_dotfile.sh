#!/usr/bin/env bash

function link_dotfile_init() {
    task_setup "link_dotfile" "Link Dotfiles" "Link dotfiles" "check_system"
}

function link_dotfile_run() {
    local overwrite_all=false backup_all=false skip_all=false

    for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink')
    do
        dst="$HOME/.$(basename "${src%.*}")"
        link_file "$src" "$dst"
    done

    # custom linkage

    # VS Code
    link_file "$DOTFILES_ROOT/code/settings.json" "$HOME/.config/Code/User/settings.json"
    link_file "$DOTFILES_ROOT/code/keybindings.json" "$HOME/.config/Code/User/keybindings.json"
}
