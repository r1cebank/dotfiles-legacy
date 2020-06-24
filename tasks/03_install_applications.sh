#!/usr/bin/env bash

function install_applications_init() {
    task_setup "install_applications" "Install Applications" "Install desktop applications" "check_system"
}

function install_applications_run() {
    PLATFORM=$(settings_get "PLATFORM")
    HOST_TYPE=$(settings_get "HOST_TYPE")
    if [ "$HOST_TYPE" = "desktop" ]; then
        if [ "$PLATFORM" = "debian" ]; then
            # Adding chrome
            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
            sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
            sudo apt-get update
            sudo apt-get install -y google-chrome-stable
            sudo apt-get install -f -y

            # Adding vscode
            curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
            sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
            sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
            sudo apt-get update
            sudo apt-get install -y code

            # install telegram
            sudo apt-add-repository ppa:atareao/telegram -y
            sudo apt-get update
            sudo apt-get install -y telegram


            # install java
            sudo apt-get install -y openjdk-8-jdk

            # install docker
            curl -fsSL get.docker.com | sh

            # install arc theme
            sudo apt-add-repository ppa:fossfreedom/arc-gtk-theme-daily -y
            sudo apt-get update
            sudo apt-get install -y arc-theme

            # install arc icon
            git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme
            ./autogen.sh --prefix=/usr
            sudo make install

            # install android studio
            sudo apt-add-repository ppa:maarten-fonville/android-studio -y
            sudo apt-get update
            sudo apt-get install -y android-studio
            /opt/android-studio/bin/studio.sh &

            # Adding hyper
            curl -L https://releases.hyper.is/download/deb > hyper.deb
            sudo dpkg -i hyper.deb
            rm hyper.deb
        elif [ "$PLATFORM" = "arch" ]; then
            # install system tools
            log_info "Installing applications."
            while read in; do yay -S "$in" --noconfirm; done < $DOTFILES_ROOT/system/apps.arch.list

            if lsmod | grep loop &> /dev/null; then
                log_info "loop is loaded!"
            else
                log_info "loop is not loaded! Enabling it now"
                sudo tee /etc/modules-load.d/loop.conf <<< "loop"
                sudo modprobe loop
            fi
            # start docker
            sudo systemctl start docker.service
            sudo systemctl enable docker.service
            sudo gpasswd -a $USER docker
        else
            log_info "skipping, system not supported"
        fi
    else
        log_info "skipping, headless host"
    fi
    return ${E_SUCCESS}
}
