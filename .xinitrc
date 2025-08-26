#!/bin/bash

# Start dwmbar
~/.local/bin/dwmbar/dwmbar &

# Set wallpaper
feh --bg-fill ~/Pictures/desktop/Goku-Kamehameha.png

# Start polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Start gnome-keyring daemon
eval $(gnome-keyring-daemon --start --components=secrets,pkcs11,ssh)
export SSH_AUTH_SOCK

# Fontconfig
export FONTCONFIG_PATH=/etc/fonts
fc-cache -f -v

# Start dwm
exec dwm
