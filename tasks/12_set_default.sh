#!/usr/bin/env bash

function set_default_init() {
    task_setup "set_default" "Set Defaults" "Setting defaults for macOS" "check_system"
}

function set_default_run() {
    PLATFORM=$(settings_get "PLATFORM")
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
    elif [ "$PLATFORM" = "debian" ]; then
        log_info "setting gnome shell favorite"
        gsettings set org.gnome.shell favorite-apps "['telegramdesktop.desktop', 'google-chrome.desktop', 'code.desktop', 'jetbrains-studio.desktop', 'slack.desktop', 'steam.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop']"
        gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
        gsettings set org.gnome.shell.extensions.user-theme name 'Arc-Dark'
        gsettings set org.gnome.desktop.interface icon-theme 'Arc'
        gsettings set org.gnome.shell enabled-extensions "['caffeine@patapon.info', 'clipboard-indicator@tudmotu.com', 'emoji-selector@maestroschan.fr', 'gnome-shell-screenshot@ttll.de', 'openweather-extension@jenslody.de', 'show-desktop-button@amivaleo', 'alternate-tab@gnome-shell-extensions.gcampax.github.com', 'auto-move-windows@gnome-shell-extensions.gcampax.github.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'status-area-horizontal-spacing@mathematical.coffee.gmail.com', 'launch-new-instance@gnome-shell-extensions.gcampax.github.com', 'places-menu@gnome-shell-extensions.gcampax.github.com', 'screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com', 'topIcons@adel.gadllah@gmail.com']
"
    fi
    # Changing default shell
    chsh -s $(which zsh);
    log_info "you need to logout to see change take effect"
    return ${E_SUCCESS}
}
