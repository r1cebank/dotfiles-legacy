#!/usr/bin/env bash

function check_system_init() {
    task_setup "check_system" "Check System" "Checking current system before bootstrap"
    settings_init ".settings"
}

function check_system_run() {
    # Platform detection
    # Mainly to differentiate between OS X, Linux and WSL
    PLATFORM=$(uname | tr "[:upper:]" "[:lower:]")
    HOST_TYPE="desktop"
    if [ "$PLATFORM" = "linux" ]; then
      # Check os type
      if hash apt-get >/dev/null 2>&1; then
        PLATFORM="debian"
      fi
      if hash pacman >/dev/null 2>&1; then
        PLATFORM="arch"
      fi
      if grep -q microsoft /proc/version; then
        HOST_TYPE="wsl"
      else
        if ask "Is this a headless host?"; then
          HOST_TYPE="headless"
        fi
      fi
    fi
    settings_set "HOST_TYPE" $HOST_TYPE
    settings_set "PLATFORM" $PLATFORM
    return ${E_SUCCESS}
}
