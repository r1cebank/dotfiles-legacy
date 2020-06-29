#!/usr/bin/env bash

function wrap_up_init() {
    task_setup "wrap_up" "Final wrap up" "Finishing install" "check_system"
}

function wrap_up_run() {
    PLATFORM=$(settings_get "PLATFORM")
    if [ "$PLATFORM" = "debian" ]; then
        if ask "Reboot?"; then
            sudo reboot
        fi
    elif [ "$PLATFORM" = "arch" ]; then
        # Force Xorg login
        sudo sed -i 's/#WaylandEnable=false/WaylandEnable=false/g' /etc/gdm/custom.conf
        # Fix yubikey-agent service
        sudo sed -i 's/multi-user.target/default.target/g' /usr/lib/systemd/user/yubikey-agent.service
        systemctl daemon-reload --user
        systemctl --user enable --now yubikey-agent
        if ask "Reboot?"; then
            sudo reboot
        fi
    fi
    return ${E_SUCCESS}
}
