# Add GNU utils to PATH
if test $(which brew)
then
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi
