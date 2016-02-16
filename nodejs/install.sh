#!/bin/sh
#
# Node.js
#
# This will install Node.js, npm and a few frequently used global deps.

# Check for nvm
if ! type "n" > /dev/null; then

  echo "  Installing Node.js for you."

  # Install n and latest LTS node.js
  curl -L http://git.io/n-install | bash -s -- -y lts

fi

# Install frequently used Node.js packages
echo "  Installing global npm packages."
npm install --global $(tr '\n' ' ' < $ZSH/nodejs/packages.list)
