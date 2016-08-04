#!/usr/bin/env bash

function bootstrap_init() {
    task_setup "bootstrap" "Bootstrap" "Bootstrap the install process" "check_system"
}

function bootstrap_run() {
    PLATFORM=$(settings_get "PLATFORM")
    log_info "You are running: $PLATFORM"
    # Install gcc, git and zsh if this is Linux
    if [ "$PLATFORM" = "debian" ]; then
        sudo apt-get install build-essential git zsh
    elif [ "$PLATFORM" = "centos" ]; then
        sudo yum install gcc gcc-c++ make openssl-devel git
    elif [ "$PLATFORM" = "darwin" ]; then
        log_info "macOS do not need bootstrap install"
    fi
    return ${E_SUCCESS}
}
