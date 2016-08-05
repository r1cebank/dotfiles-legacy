# Setup PATH to include npm global modules and local npm executables
export PATH="$HOME/.npm/bin:./node_modules/.bin:$PATH"

# Setup NODE_PATH to be able to require globally installed modules
export NODE_PATH="$HOME/.npm/lib/node_modules"

# Setup MANPATH to include npm global modules
export MANPATH="$HOME/.npm/share/man:$MANPATH"

# If I use these dotfiles, most likely this is a development machine
export NODE_ENV="development"

# Set n prefix and add node binaries to path
export N_PREFIX="$HOME/n";
[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
