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
        dconf load /com/gexperts/Tilix/ < $DOTFILES_ROOT/tilix/tilix.conf
        if hash gnome-shell >/dev/null 2>&1; then
            log_info "setting gnome settings"
            gsettings set org.gnome.desktop.interface gtk-theme 'Adapta-Nokto'
            gsettings set org.gnome.shell.extensions.user-theme name 'Adapta-Noktok'
            gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Adapta-Nokto'
            gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
            gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button false
            gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.gedit.desktop', 'visual-studio-code.desktop', 'com.gexperts.Tilix.desktop', 'pamac-manager.desktop', 'org.gnome.Screenshot.desktop']"
        fi
    elif [ "$PLATFORM" = "arch" ]; then
        dconf load /com/gexperts/Tilix/ < $DOTFILES_ROOT/tilix/tilix.conf
        # skipping setting default
        if hash gnome-shell >/dev/null 2>&1; then
            log_info "setting gnome settings"
            gsettings set org.gnome.desktop.interface gtk-theme 'Adapta-Nokto'
            gsettings set org.gnome.shell.extensions.user-theme name 'Adapta-Nokto'
            gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Adapta-Nokto'
            gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
            gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button false
            gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.gedit.desktop', 'visual-studio-code.desktop', 'com.gexperts.Tilix.desktop', 'pamac-manager.desktop', 'org.gnome.Screenshot.desktop']"
        fi
    fi
    # Changing default shell
    chsh -s $(which zsh);
    log_info "you need to logout to see change take effect"
    return ${E_SUCCESS}
}
