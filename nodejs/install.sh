#!/bin/sh
#
# Node.js
#
# This will install Node.js, npm and a few frequently used global deps.

# Check for nvm
if ! type "n" > /dev/null; then

  echo "  Installing Node.js for you."

  # Install n and latest LTS node.js
  curl -L http://git.io/n-install | bash -s -- -n -y lts

  # Reload nodejs environment variables
  source $HOME/.dotfiles/nodejs/env.zsh

  # Install the last node lts
  n lts

  # Hide the folder so that it's not visible
  if [ "$PLATFORM" = "darwin" ]; then
    chflags hidden ~/n
  else
    echo "n" >> $HOME/.hidden
  fi

fi

# Install frequently used Node.js packages
echo "  Installing global npm packages."
npm install --global $(tr '\n' ' ' < $ZSH/nodejs/packages.list)
