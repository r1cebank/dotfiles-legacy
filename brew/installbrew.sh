#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if ! type "brew" > /dev/null; then
  echo "  Installing Homebrew for you."

  # Install the correct homebrew for each OS type
  if [ "$PLATFORM" = "darwin" ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
  fi

fi

$ZSH/osx/brew.sh
