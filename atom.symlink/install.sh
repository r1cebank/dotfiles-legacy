#!/bin/sh
#
# Atom Editor
#
# This will install atom editor packages.

# Check for apm
if test ! $(which apm)
then
  echo "  Installing Atom Package Manager for you."

  # Install apm from npm
  npm install --global atom-package-manager

fi

echo "  Installing atom packages."
apm install $(tr '\n' ' ' < $ZSH/atom.symlink/packages.list)
