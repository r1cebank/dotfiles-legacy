#!/usr/bin/env bash

function run {
  if ! pgrep $1 ; then
    $@&
  fi
}

run picom --shadow-exclude '!focused'
run nitrogen --restore
