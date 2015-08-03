
# Setup PATH
export PATH="./bin:$ZSH/bin:$PATH"
export MANPATH="$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
 export EDITOR='nano'
else
 export EDITOR='atom'
fi
