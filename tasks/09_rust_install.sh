#!/usr/bin/env bash

function rust_install_init() {
    task_setup "rust_install" "rust Install" "Install rust" "check_system"
}

function rust_install_run() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    return ${E_SUCCESS}
}
