#!/usr/bin/env bash

function bootstrap_init() {
    task_setup "bootstrap" "Bootstrap" "Bootstrap the install process" "check_system"
}

function bootstrap_run() {
    log_info "You are running: $(settings_get "PLATFORM")"
    return ${E_SUCCESS}
}
