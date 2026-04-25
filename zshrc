#Path
export PATH="$HOME/.local/bin:$PATH" 
export TERM=xterm-256color
#Zoxide
eval "$(zoxide init zsh)"
#fzf
source /usr/share/fzf/shell/key-bindings.zsh
eval "$(fzf --zsh)"

#Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

#Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'
zinit light Aloxaf/fzf-tab

#Completions
autoload -U compinit && compinit
fpath+=${ZDOTDIR:-~}/.zsh_functions

#History
HISTFILE=~/.zsh_history
HISTFILEZISE=150
HISTTIMEFORMAT="%a%d%b%c"
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

#Bindings
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

#Colors
reset="\e[0m"
black="\e[38;5;16m"
white="\e[38;5;254m"
blue="\e[38;5;21m"
yellow="\e[38;5;3m"
green="\e[38;5;47m"
red="\e[38;5;196m"
purple="\e[38;5;93m"
orange="\e[38;5;166m"

#Prompt
PS1="%F{red}%n%f %F{white}%~%f"$'\n'"%F{red}❯%f "
PS2="%F{red}%>%f"

