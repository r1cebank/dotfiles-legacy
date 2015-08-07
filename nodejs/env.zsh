# Setup PATH to include npm global modules and local npm executables
export PATH="./node_modules/.bin:$HOME/.npm/bin:$PATH"

# Setup MANPATH to include npm global modules
export MANPATH="$HOME/.npm/share/man:$MANPATH"

# If I use these dotfiles, most likely this is a development machine
export NODE_ENV="development"
