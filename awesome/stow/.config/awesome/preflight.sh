#!/usr/bin/env bash

function check() {
    which "${1}" >/dev/null 2>&1
    if [[ $? != 0 ]]; then
        notify-send -u critical "System Notification" "Program ${1} not found in path, some features may not work"
    fi
}

check "i3lock"
check "xbacklight"
check "pactl"
check "acpi"
check "rofi"
check "picom"
check "xmousepasteblock"
check "xautolock"
