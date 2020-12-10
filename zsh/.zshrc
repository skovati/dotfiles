HISTFILE=~/.histfile
HISTSIZE=64000
SAVEHIST=64000
unsetopt beep
bindkey -v

autoload -Uz compinit promptinit
compinit
promptinit

LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

alias ls="ls --color -F"

PROMPT='%F{green}%~%f '
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
