#!/usr/bin/env bash

function wrap_up_init() {
    task_setup "wrap_up" "Final wrap up" "Finishing install" "check_system"
}

wait_file() {
  local file="$1"; shift
  local wait_seconds="${1:-10}"; shift # 10 seconds as default timeout

  until test $((wait_seconds--)) -eq 0 -o -f "$file" ; do sleep 1; done

  ((++wait_seconds))
}

function wrap_up_run() {
    PLATFORM=$(settings_get "PLATFORM")
    HOST_TYPE=$(settings_get "HOST_TYPE")
    if [ "$HOST_TYPE" = "wsl" ]; then
        sed -i 's/bin\"/bin:\/mnt\/c\/Program Files\/Microsoft VS Code\/bin\"/g' $HOME/.dotfiles/zsh/path.zsh
        return ${E_SUCCESS}
    fi
    if [ "$PLATFORM" = "debian" ]; then
        if ask "Reboot?"; then
            sudo reboot
        fi
    elif [ "$PLATFORM" = "arch" ]; then
        # Set plymouth theme
        sudo plymouth-set-default-theme -R arch-logo

        # Apply Xorg settings
        sudo cp -f $DOTFILES_ROOT/xorg/*.conf /etc/X11/xorg.conf.d/

        # Copy over wallpapers
        cp -R $DOTFILES_ROOT/Wallpapers $HOME/Pictures

        # Apply wakelock service
        sudo cp -f $DOTFILES_ROOT/system/wakelock@.service /etc/systemd/system/
        sudo systemctl enable wakelock@$(whoami) --now

        # Disable and enable python3-validity (fprint helper T480)
        sudo systemctl stop python3-validity
        sudo validity-sensors-firmware
        sudo python3 /usr/share/python-validity/playground/factory-reset.py
        sudo systemctl start python3-validity

        # Enable intel module
        sudo sed -i 's/MODULES=()/MODULES=(i915)/g' /etc/mkinitcpio.conf
        sudo sed -i 's/HOOKS=(base udev systemd/HOOKS=(base udev systemd sd-plymouth/g' /etc/mkinitcpio.conf

        # Enable boot splash
        sudo sed -i '$s/$/ quiet splash loglevel=3 rd.udev.log_priority=3 vt.global_cursor_default=0/' /boot/loader/entries/archlinux.conf

        # Make linux-zen default if installed
        if [ -f /boot/loader/entries/archlinux-zen.conf ]; then
            sudo sed -i '$s/$/ quiet splash loglevel=3 rd.udev.log_priority=3 vt.global_cursor_default=0/' /boot/loader/entries/archlinux-zen.conf
            bootctl set-default archlinux-zen.conf
        fi

        # Reduce systemd delay
        sudo sed -i 's/timeout .*/ timeout 3/' /boot/loader/loader.conf

        # Apply mkinitcpio
        sudo mkinitcpio -P
    fi
    return ${E_SUCCESS}
}
