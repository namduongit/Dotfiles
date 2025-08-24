### Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)       # Include hidden files.

### Ignore upper and lowercase when TAB completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# --------------- PLUGIN --------------- #
ZSH_PLUGIN_DIR="$HOME/.config/zsh/plugins"

# zsh-autosuggestions
source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting
source "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# --------------- PROMPT --------------- #
# Prompt
PROMPT=$'%B%F{blue}[%m@%n]%f%F{yellow}%~%f\n%F{white}-> %f%b'

# --------------- SOURCE --------------- #
source "$HOME/.config/zsh/zsh-vimode"

# ---------------- Alias --------------- #
alias start-docker="systemctl start docker"
alias start-hdmi="xrandr --output HDMI-1-0 --auto --right-of eDP1"
alias screen-shot=".local/bin/screenshot/screenshot.sh"
