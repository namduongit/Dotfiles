# ----------- History - Cache ---------- #
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/cache

# --------------- SOURCE --------------- #
source /usr/share/nvm/init-nvm.sh   # (nvm cần trong môi trường login)

# --------------- EXPORT --------------- #
export M2_HOME=$HOME/apps/apache-maven-3.9.11
export PATH=$M2_HOME/bin:$PATH

# Input method (em đã để trong zprofile chuẩn rồi)
export GTK_IM_METHOD=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
