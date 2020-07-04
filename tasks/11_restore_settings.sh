#!/usr/bin/env bash

function restore_settings_init() {
    task_setup "restore_settings" "Restore settings" "Restore user settings" "check_system"
}

function restore_settings_run() {
    PLATFORM=$(settings_get "PLATFORM")
    HOST_TYPE=$(settings_get "HOST_TYPE")
    if [ "$HOST_TYPE" = "desktop" ]; then
        if [ "$PLATFORM" = "darwin" ]; then
            log_info "skipping for OSX"
        elif [ "$PLATFORM" = "debian" ]; then
            dconf load /com/gexperts/Tilix/ < $DOTFILES_ROOT/tilix/tilix.conf
            if hash gnome-shell >/dev/null 2>&1; then
                log_info "setting gnome settings"
                gsettings set org.gnome.desktop.interface gtk-theme 'Adapta-Nokto'
                gsettings set org.gnome.shell.extensions.user-theme name 'Adapta-Noktok'
                gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Adapta-Nokto'
                gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
                gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button false
                gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
                gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.gedit.desktop', 'visual-studio-code.desktop', 'com.gexperts.Tilix.desktop', 'pamac-manager.desktop', 'org.gnome.Screenshot.desktop']"
            fi
        elif [ "$PLATFORM" = "arch" ]; then
            # skipping setting default
            if hash gnome-shell >/dev/null 2>&1; then
                log_info "loading gnome settings"
                dconf load / < $DOTFILES_ROOT/gnome/dconf-settings.ini
                # killall -SIGQUIT gnome-shell
            fi
        fi
        # start the plank dock
        if hash plank >/dev/null 2>&1; then
            mkdir -p $HOME/.config/autostart
            cp $DOTFILES_ROOT/gnome/autostart/plank.desktop $HOME/.config/autostart/plank.desktop
            mkdir -p $HOME/.config/plank/dock1/launchers
            rm -rf $HOME/.config/plank/dock1/launchers/*
            cp $DOTFILES_ROOT/plank/dock1/*.dockitem $HOME/.config/plank/dock1/launchers
            setsid plank &>/dev/null
        fi
    else
        log_info "not running for headless host"
    fi
    # Changing default shell
    chsh -s $(which zsh);
    log_info "you need to logout to see change take effect"
    return ${E_SUCCESS}
}
