#!/bin/sh
#
# App Store install
#
# This will install all apps from app store

# Check for mas
if type "apm" > /dev/null; then
  echo "  Updating existing App Store apps"
  mas upgrade
  echo "  Installing App Store apps."
  while read p; do
    mas install $p
  done < ./applications.list
else
  echo "  Did not find mas, skipping app store applications."
fi
