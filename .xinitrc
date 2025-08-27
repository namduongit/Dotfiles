#!/bin/bash

# Start dwmbar
~/.local/bin/dwmbar/dwmbar &

# Set wallpaper
feh --bg-fill ~/Pictures/desktop/Goku-Kamehameha.png

# Start polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Start gnome-keyring daemon
# Start gnome-keyring daemon
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL

# Start dwm
exec dwm