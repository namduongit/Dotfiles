#!/bin/bash

# ------------------------- PATH ------------------------- #
HOME_PATH="$HOME"
LOCAL_PATH="$HOME/.local"

# ------------------------- REPOS ------------------------- #
GIT_DWM="https://github.com/namduongit/dwm.git"
GIT_IMAGE="https://github.com/namduongit/images.git"
GIT_YAY="https://aur.archlinux.org/yay.git"

# ------------------------- UTILS ------------------------- #
function createDir() {
    mkdir -p "$HOME_PATH/Pictures"
    mkdir -p "$HOME_PATH/Documents"
    mkdir -p "$HOME_PATH/Downloads"
    mkdir -p "$HOME_PATH/Repository"
    mkdir -p "$HOME_PATH/Videos"
}

function createHiden() {
    mkdir -p "$HOME_PATH/.fonts"
    mkdir -p "$HOME_PATH/.config"
    mkdir -p "$HOME_PATH/.local"
    mkdir -p "$HOME_PATH/.cache"
}

function configCache() {
    mkdir -p "$HOME_PATH/.cache/zsh"
    cp -r "./cache/zsh" "$HOME_PATH/.cache"
}

function configFont() {
    cp -r "./fonts/*.ttf" "$HOME_PATH/.fonts"
}

function configConfig() {
    cp -r "./config/*" "$HOME_PATH/.config"
}

function configLocal() {
    mkdir -p "$HOME_PATH/.local/bin"
    cp -r "./local/*" "$HOME_PATH/.local/bin"
}

function configTouchPad() {
    sudo cp -r "./builds/X11/30-touchpad.conf" /etc/X11/xorg.conf.d/30-touchpad.conf
}

function configBackground() {
    mkdir -p "$HOME_PATH/Pictures/desktop" 
    mkdir -p "$HOME_PATH/Pictures/images"
    cp -r "./images/Goku-Kamehameha.png" "$HOME_PATH/Pictures/desktop" 
}

function configProfile() {
    cp -r "./.xinitrc" "$HOME_PATH"
    cp -r "./.zshrc" "$HOME_PATH"
    cp -r "./.zprofile" "$HOME_PATH"
}

# ------------------------- FUNC ------------------------- #

function installDWM() {
    echo "Install DWM"
    cd "$HOME_PATH/Builds" && git clone "$GIT_DWM" && cd dwm && make clean install && cd -
    echo "Install DWM completed"
}

function installYay() {
    cd "$HOME_PATH/Builds" && git clone "$GIT_YAY" && cd yay && makepkg -si && cd -
    echo "Install some package from AUR"
    while IFS= read -r pkg || [[ -n "$pkg" ]]; do
        [[ -z "$pkg" ]] && continue
        yay -S --needed "$pkg"
    done < "./package/yay"
}

function installPackage() {
    echo "Install some package from Pacman"
    while IFS= read -r pkg || [[ -n "$pkg" ]]; do
        [[ -z "$pkg" ]] && continue
        [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
        pacman -S --needed "$pkg"
    done < "./package/pkg"
}

function installNvidiaGraphic() {
    echo "Install nvidia graphic"
    while IFS= read -r pkg || [[ -n "$pkg" ]]; do
        [[ -z "$pkg" ]] && continue
        pacman -S --needed "$pkg"
    done < "./package/nvidia"
}

function installIntelGraphic() {
    echo "Install intel graphic"
    while IFS= read -r pkg || [[ -n "$pkg" ]]; do
        [[ -z "$pkg" ]] && continue
        pacman -S --needed "$pkg"
    done < "./package/intel"
}

function symlinkConfig() {
    # Zshrc
    mkdir -p ~/.config/zsh ~/.config/zsh/plugins
    mv ~/.zshrc ~/.config/zsh/.zshrc
    ln -s ~/.config/zsh/.zshrc ~/.zshrc
    # Zsh profile
    mv ~/.zprofile ~/.config/zsh/.zprofile
    ln -s ~/.config/zsh/.zprofile ~/.zprofile
    # Docker
    mkdir -p ~/.config/docker
    mv ~/.docker ~/.config/docker
    ln -s ~/.config/docker ~/.docker
}


function main() {
    createDir
    createHiden
    configCache
    configFont
    configConfig
    configLocal
    configTouchPad
    configBackground

    installDWM
    installYay
    installPackage
    installNvidiaGraphic
    installIntelGraphic

    configProfile
    reboot
}

# ------------------------- MAIN ------------------------- #
main
