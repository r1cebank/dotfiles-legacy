
# ---------------------------------------------------------------------------- #
# Preferred file manipulation utilities.                                       #
# ---------------------------------------------------------------------------- #
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ls='ls -G'                            # Preferred 'ls' implementations
alias ll='ls -FGlAhp'
alias la='ls -aG'

# ---------------------------------------------------------------------------- #
# Changing current working directory.                                          #
# ---------------------------------------------------------------------------- #
cd() { builtin cd "$@"; ls; }               # Always list contents upon 'cd'
alias ~="cd ~"                              # ~: Go Home
alias cd..='cd ../'                         # Go back 1 directory level
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels

# ---------------------------------------------------------------------------- #
# Various shortcuts to save precious keystrokes.                               #
# ---------------------------------------------------------------------------- #
alias c='clear'                             # Clear terminal

# ---------------------------------------------------------------------------- #
# Copy public key to clipboard.                                                #
# ---------------------------------------------------------------------------- #
alias pubkey='more ~/.ssh/id_rsa.pub | pbcopy | echo "=> Public key copied."'
