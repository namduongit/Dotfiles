### XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

### Zsh config paths
ZDOTDIR="$XDG_CONFIG_HOME/zsh"
ZSH_PLUGIN_DIR="$ZDOTDIR/plugins"
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"

### Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d "$ZSH_COMPDUMP"
_comp_options+=(globdots)

### Ignore case when TAB completing
zstyle ':completion:*' matcher-list '' \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

### Plugins
# zsh-autosuggestions
source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"

# NVM (đặt vào XDG)
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# zsh-syntax-highlighting
source "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

### Prompt
PROMPT=$'%B%F{blue}[%m@%n]%f%F{yellow}%~%f\n%F{white}-> %f%b'

### Extra configs
source "$ZDOTDIR/zsh-vimode"

### Aliases
alias start-docker="systemctl start docker"
alias start-hdmi="xrandr --output HDMI-1-0 --auto --right-of eDP1"
alias screen-shot="$HOME/.local/bin/screenshot/screenshot.sh"