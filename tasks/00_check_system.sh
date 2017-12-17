#!/usr/bin/env bash

function check_system_init() {
    task_setup "check_system" "Check System" "Checking current system before bootstrap"
    settings_init ".settings"
}

function check_system_run() {
    # Platform detection
    # Mainly to differentiate between OS X, Ubuntu and CentOS
    PLATFORM=$(uname | tr "[:upper:]" "[:lower:]")
    if [ "$PLATFORM" = "linux" ]; then
      if hash yum >/dev/null 2>&1; then
        PLATFORM="centos"
      fi
      if hash apt-get >/dev/null 2>&1; then
        PLATFORM="debian"
      fi
    fi
    settings_set "PLATFORM" $PLATFORM
    return ${E_SUCCESS}
}
