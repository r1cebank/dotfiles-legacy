#!/bin/sh
#
# App Store install
#
# This will install all apps from app store

# Check for mas
if type "mas" > /dev/null; then
  echo "  Updating existing App Store apps"
  mas upgrade
  echo "  Installing App Store apps."
  while read p; do
    if [ ! -f $ZSH/mas/$p ]; then
        mas install $p
        touch $ZSH/mas/$p
    else
        echo "Skipping "$p
    fi
  done < $ZSH/mas/applications.list
else
  echo "  Did not find mas, skipping app store applications."
fi
