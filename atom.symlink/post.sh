#!/bin/sh
#
# Atom Editor
#
# This will install atom editor packages.

# Check for apm
if type "apm" > /dev/null; then
  echo "  Installing atom packages."
  apm install $(tr '\n' ' ' < $ZSH/atom.symlink/packages.list)
else
  echo "  Did not find apm, skipping Atom packages."
fi
