#!/usr/bin/env bash

# Pre-flight checks
sh ~/.config/awesome/preflight.sh

function run {
  if ! pgrep $1 ; then
    $@&
  fi
}

run picom --config ~/.config/picom/picom.conf
run xmousepasteblock
run /usr/bin/fcitx5
run nm-applet
run xss-lock --transfer-sleep-lock -- ~/.dotfiles/bin/lock

xautolock -detectsleep -time 30 -locker "~/.dotfiles/bin/lock" -notify 30 -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'"
