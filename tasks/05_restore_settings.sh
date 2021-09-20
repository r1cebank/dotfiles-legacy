#!/usr/bin/env bash

function restore_settings_init() {
    task_setup "restore_settings" "Restore settings" "Restore user settings" "check_system"
}

function restore_settings_run() {
    PLATFORM=$(settings_get "PLATFORM")
    HOST_TYPE=$(settings_get "HOST_TYPE")
    if [ "$HOST_TYPE" = "desktop" ]; then
        if [ "$PLATFORM" = "darwin" ]; then
            log_info "skipping for OSX"
        elif [ "$PLATFORM" = "debian" ]; then
            log_info "skipping for debian"
        elif [ "$PLATFORM" = "arch" ]; then
            log_info "skipping for arch"
        fi
    else
        log_info "not running for headless host"
    fi
    log_info "updating default shell"
    # Changing default shell
    chsh -s $(which zsh);
    log_info "you need to logout to see change take effect"
    return ${E_SUCCESS}
}
