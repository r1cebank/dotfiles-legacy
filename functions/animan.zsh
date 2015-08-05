#
# Anime Management Toolbelt
#
# Author:  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# License: MIT

# TODO Install dependencies
if [[ -n $(type foo >/dev/null 2>&1) ]]; then
  npm install --global renamer
fi

# Constants and expressions
DELIMITER_L="\[\( "
DELIMITER_R="\]\) "
REGEX_INDEX="\d{2}"
REGEX_EXT="\.([\w\d]+)$"

# Rename anime in a folder
aniren() {
  REGEX=".*(?:[$DELIMITER_L])($REGEX_INDEX)(?:[$DELIMITER_R]).*$REGEX_EXT"
  renamer -e -f "$REGEX" -r "$(cwd)[\$1].\$2" --dry-run "*.{mp4,mkv,ass}"

  echo
  echo " - Press [Enter] to rename, [Ctrl-C] to cancel"
  read -n 1

  renamer -e -f "$REGEX" -r "$(cwd)[\$1].\$2" "*.{mp4,mkv,ass}" > /dev/null

  echo
  echo " - Complete!"
}
