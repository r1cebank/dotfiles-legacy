#!/usr/bin/env bash

function final_wrap_up_init() {
    task_setup "final_wrap_up" "Final wrap up" "Finishing install" "check_system"
}

function final_wrap_up_run() {
    PLATFORM=$(settings_get "PLATFORM")
    if [ "$PLATFORM" = "debian" ]; then
        # Nothing
    elif [ "$PLATFORM" = "arch" ]; then
        if ask "Reboot?"; then
            sudo reboot
        fi
    fi
    return ${E_SUCCESS}
}
