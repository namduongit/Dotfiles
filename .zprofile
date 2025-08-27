# ----------- History - Cache ---------- #
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/cache

# --------------- SOURCE --------------- #
source /usr/share/nvm/init-nvm.sh

# --------------- EXPORT --------------- #
export M2_HOME=$HOME/apps/apache-maven-3.9.11
export PATH=$M2_HOME/bin:$PATH

# Input method
export GTK_IM_METHOD=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
