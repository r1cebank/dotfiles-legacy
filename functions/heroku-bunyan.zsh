#
# Heroku-bunyan log watcher.
#
# Author:  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# License: MIT

heronyan() {
  heroku logs $@ | sed 's/.*app\[web\..*\]\: //' | bunyan
}
