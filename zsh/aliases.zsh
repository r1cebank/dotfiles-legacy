
# Reloads the .zshrc file
alias reload!='. ~/.zshrc'

# map xdg-open to open
alias xdg-open='xdg-open'

# Updates the .dotfiles
alias update!='(cd $ZSH > /dev/null; git pull;); reload!'

# Fix sudo + alias bug
alias sudo='sudo '
