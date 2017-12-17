#!/usr/bin/env bash

function install_dependencies_init() {
    task_setup "install_dependencies" "Install dependencies" "Install system packages" "check_system"
}

function bootstrap_run() {
    PLATFORM=$(settings_get "PLATFORM")
    log_info "You are running: $PLATFORM"
    # Install gcc, git and zsh if this is Linux
    if [ "$PLATFORM" = "debian" ]; then
        sudo apt-get update
        sudo apt-get install -y build-essential git zsh curl file python-setuptools
    elif [ "$PLATFORM" = "centos" ]; then
        yum check-update
        sudo yum install gcc gcc-c++ make openssl-devel git curl file python-setuptools
    elif [ "$PLATFORM" = "darwin" ]; then
        log_info "macOS have existing dependencies we can work with"
    fi
    return ${E_SUCCESS}
}
