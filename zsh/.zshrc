# some sane defaults
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
unsetopt beep
# enable comments in interactive shell
setopt interactivecomments 
# set vim mode
bindkey -v

# random zsh compat
autoload -Uz compinit promptinit edit-command-line
compinit
promptinit
zle -N edit-command-line

# make ls pretty
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=30;41:sg=30;43:tw=30;42:ow=30;42:st=30;44:ex=01;32:';
export LS_COLORS

alias ls="ls --color -F"

# general aliases
source /home/skovati/.zsh_alias

# source private env vars
# source /home/skovati/.zsh_secret

# open command in vim
bindkey '\ev' edit-command-line

# show git branch if in repo
function git_branch() {
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch == "" ]]; then
        :
    else
        echo '('$branch')'
    fi
}

# set prompt
setopt prompt_subst
PROMPT=' %F{green}%~%f%F{yellow}$(git_branch) '

# source addons
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# addons config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#707070'
