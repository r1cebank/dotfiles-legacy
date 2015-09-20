#!/bin/sh
#
# Node.js
#
# This will install Node.js, npm and a few frequently used global deps.

# Check for node
if test ! $(which node)
then
  echo "  Installing Node.js for you."


  # Mac OSX: Install Node.js using homebrew
  if [[ $(uname) == 'Darwin' ]]
  then
    brew install nvm
    brew install node
  fi

  # Ubuntu: Install Node.js using apt-get
  if [[ $(uname) == 'Linux' ]]
  then
    curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
    sudo apt-get install -y nodejs
  fi

fi

# Install frequently used Node.js packages
echo "  Installing global npm packages."
npm install --global $(tr '\n' ' ' < $ZSH/nodejs/packages.list)
