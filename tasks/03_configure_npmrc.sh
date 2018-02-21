#!/usr/bin/env bash

function configure_npmrc_init() {
    task_setup "configure_npmrc" "Install npmrc" "Install .npmrc"
}

function configure_npmrc_run() {
    return ${E_SUCCESS}
}
