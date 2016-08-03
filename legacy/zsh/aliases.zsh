
# Reloads the .zshrc file
alias reload!='. ~/.zshrc'

# Updates the .dotfiles
alias update!='(cd $ZSH > /dev/null; git pull;); reload!'

# Fix sudo + alias bug
alias sudo='sudo '
