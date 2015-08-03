#!/bin/sh
#
# Node.js
#
# This will install Node.js, npm and a few frequently used global deps.

# Check for node
if test ! $(which node)
then
  echo "  Installing Node.js for you."

  # Install Node.js using homebrew
  brew install node

fi

# Install frequently used Node.js packages
echo "  Installing global npm packages."
npm install --global $(tr '\n' ' ' < $ZSH/nodejs/packages.list)
