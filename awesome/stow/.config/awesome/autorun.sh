#!/usr/bin/env bash

function run {
  if ! pgrep $1 ; then
    $@&
  fi
}

run picom --shadow-exclude '!focused'
run nitrogen --restore
run xmousepasteblock
run /usr/bin/fcitx5

xautolock -detectsleep -time 30 -locker "~/.dotfiles/bin/lock" -notify 30 -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'"
