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
run synclient RightButtonAreaLeft=0 RightButtonAreaTop=0
