# Setup PATH to include npm global modules and local npm executables
export PATH="./node_modules/.bin:$HOME/.npm/bin:$PATH"

# Setup NODE_PATH to be able to require globally installed modules
export NODE_PATH="$HOME/.npm/lib/node_modules"

# Setup MANPATH to include npm global modules
export MANPATH="$HOME/.npm/share/man:$MANPATH"

# If I use these dotfiles, most likely this is a development machine
export NODE_ENV="development"

# Node Version Manager
if type "nvm" > /dev/null; then
  export NVM_DIR="$HOME/.nvm"
  source NVM_DIR/nvm.sh
else
  echo "NVM is not installed!"
fi
