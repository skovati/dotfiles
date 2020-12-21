# some sane defaults
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
unsetopt beep

# set vim mode
bindkey -v

# random zsh compat
autoload -Uz compinit promptinit
compinit
promptinit

# make ls pretty
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

alias ls="ls --color -F"

# general aliases
source /home/skovati/.zsh_alias
alias syu="sudo pacman -Syu"

PROMPT='%F{green}%~%f '

# source addons
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
