#!/bin/sh
#
# Adding applications to dock
#

echo "Adding apps to dock"

dockDataPre="<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>"
dockDataPro="</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

#iTerm
defaults write com.apple.dock persistent-apps -array-add $dockDataPre$(readlink ~/Applications/iTerm.app)$dockDataPro

#Atom
defaults write com.apple.dock persistent-apps -array-add $dockDataPre$(readlink ~/Applications/Atom.app)$dockDataPro

#Slack
defaults write com.apple.dock persistent-apps -array-add $dockDataPre$(echo "/Applications/Slack.app")$dockDataPro

#Dash
defaults write com.apple.dock persistent-apps -array-add $dockDataPre$(echo "/Applications/Dash.app")$dockDataPro

#gitkraken
defaults write com.apple.dock persistent-apps -array-add $dockDataPre$(echo "/Applications/GitKraken.app")$dockDataPro


# #Chrome
# defaults write com.apple.dock persistent-apps -array-add $dockDataPre$(echo "'Google cheom'")$dockDataPro
#
# #Nylas N1
# # defaults write com.apple.dock persistent-apps -array-add $dockDataPre$(readlink ~/Applications/Nylas N1.app)$dockDataPro
#

killall -HUP Dock

echo "Dock apps added"
