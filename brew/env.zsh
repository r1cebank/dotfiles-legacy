# Add GNU utils to PATH
if type "brew" > /dev/null; then
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi
