#!/bin/sh
#
# Node.js
#
# This will install Node.js, npm and a few frequently used global deps.

# Check for node
if ! type "node" > /dev/null; then

  echo "  Installing Node.js for you."

  # Manually clone NVM repo for the newest release
  git clone https://github.com/creationix/nvm.git ~/.nvm
  cd ~/.nvm
  git checkout `git describe --abbrev=0 --tags`

  # Install latest release of Node.js v4.x
  nvm install v4.3.0

fi

# Install frequently used Node.js packages
echo "  Installing global npm packages."
npm install --global $(tr '\n' ' ' < $ZSH/nodejs/packages.list)
