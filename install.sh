#!/bin/bash

HOME_PATH="$HOME"
LOCAL_PATH="$HOME/.local"

MY_DWM="https://github.com/namduongit/dwm.git"
MY_IMAGE="https://github.com/namduongit/images.git"

YAY="https://aur.archlinux.org/yay.git"

createDir() {
    mkdir -p "$HOME_PATH/Pictures"
    mkdir -p "$HOME_PATH/Pictures/desktop"
    mkdir -p "$HOME_PATH/builds"
    mkdir -p "$HOME_PATH/images"
    mkdir -p "$HOME_PATH/.fonts"
    mkdir -p "$HOME_PATH/.config"
    mkdir -p "$HOME_PATH/.local"
    mkdir -p "$HOME_PATH/.local/bin"
}

moveBuildConfig() {
    cp -r "./config/*" "$HOME_PATH/.config"
    cp -r "./fonts/*" "$HOME_PATH/.fonts"
    cp -r "./builds/dwmbar" "$HOME_PATH/.local/bin"
}

installDWM() {
    cd "$HOME_PATH/builds" && git clone "$MY_DWM" && cd dwm && make clean install && cd -
    read -p "Do you want to download my image? (y/n): " choice
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        cd "$HOME_PATH/images" && git clone "$MY_IMAGE"
    else
        echo "Skip install images."
    fi
}

buildYay() {
    cd "$HOME_PATH/builds" && git clone "$YAY" && cd yay && makepkg -si && cd -
    echo "Install some package from AUR"
    while IFS= read -r pkg || [[ -n "$pkg" ]]; do
        [[ -z "$pkg" ]] && continue
        yay -S --needed "$pkg"
    done < "./package/yay"
}


installNvidiaGraphic() {
    echo "Install nvidia graphic"
    while IFS= read -r pkg || [[ -n "$pkg" ]]; do
        [[ -z "$pkg" ]] && continue
        pacman -S --needed "$pkg"
    done < "./package/nvidia"
}

installIntelGraphic() {
    echo "Install intel graphic"
    while IFS= read -r pkg || [[ -n "$pkg" ]]; do
        [[ -z "$pkg" ]] && continue
        pacman -S --needed "$pkg"
    done < "./package/intel"
}

installPackage() {
    echo "Install all package in ./package/package-list"
    while IFS= read -r pkg || [[ -n "$pkg" ]]; do
        [[ -z "$pkg" ]] && continue
        [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
        pacman -S --needed "$pkg"
    done < "./package/pkg"
}

buildTouchPad() {
    sudo cp -r "./builds/X11/30-touchpad.conf" /etc/X11/xorg.conf.d/30-touchpad.conf
}

moveProfile() {
    cp -r ".xinitrc" "~/"
    cp -r ".zprofile" "~/"
    cp -r ".zshrc" "~/"
    cp -r "./builds/Goku-Kamehameha.png" "$HOME_PATH/Pictures/desktop"
}

symlinkConfig() {
    # Zshrc
    mkdir -p ~/.config/zsh ~/.cache/zsh ~/.config/zsh/plugins
    mv ~/.zshrc ~/.config/zsh/.zshrc
    ln -s ~/.config/zsh/.zshrc ~/.zshrc
    # NVM
    mv ~/.nvm ~/.config/nvm
    # Docker
    mkdir -p ~/.config/docker
    mv ~/.docker ~/.config/docker
    ln -s ~/.config/docker ~/.docker
    # Zsh profile
    mkdir -p ~/.config/zsh
    mv ~/.zprofile ~/.config/zsh/.zprofile
    ln -s ~/.config/zsh/.zprofile ~/.zprofile
}

main() {
    createDir
    moveBuildConfig
    
    installDWM
    installYay
    installNvidiaGraphic
    installIntelGraphic
    installPackage

    buildTouchPad

    moveProfile

    symlinkConfig

    reboot
}

main

