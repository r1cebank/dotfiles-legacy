# Sets reasonable OS X defaults.
#
# Or, in other words, set shit how I like in OS X.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#
# Run ./set-defaults.sh and you'll be good to go.

if [ "$PLATFORM" = "darwin" ]; then

  # Show the ~/Library folder.
  chflags nohidden ~/Library

  # Set the Finder prefs for showing a few different volumes on the Desktop.
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

  # Set up Safari for development.
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

  # Disable guest access
  sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
  sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool NO
  
  # Display crash dialogs as notifications
  defaults write com.apple.CrashReporter UseUNC 1

fi
