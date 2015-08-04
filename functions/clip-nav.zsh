#
# Clipboard navigation
#
# Author:  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# License: MIT


# Copies the basename of current working directory to the clipboard
cpwd() {
  basename $(pwd) | tr -d '\n' | pbcopy
  echo ">> Directory name copied."
}

# Copies the path of current working directory to clipboard
cpath() {
  pwd | tr -d '\n' | pbcopy
  echo ">> Directory path copied."
}

# Goes to the directory whose path is in the clipboard
ccd() {
  cd "$(pbpaste)"
}
