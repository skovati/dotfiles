#!/bin/zsh

########################################
# EXPORTS
########################################
# programming language stuff
export GOPATH="/home/skovati/dev/go"
# fixes matlab lol
export _JAVA_AWT_WM_NONREPARENTING=1
# java language server env thing for nvim
export JDTLS_HOME=/usr/share/java/jdtls

# actually important
export PATH=/home/skovati/.local/bin:$GOPATH/bin:/home/skovati/.cargo/bin:$PATH
export EDITOR="nvim"
export VISUAL="nvim"
export READER="zathura"
export IMAGE="nsxiv"
export TERMINAL="alacritty"
export TZ='America/Chicago'
export MANPAGER='nvim +Man!'

# xdg dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DESKTOP_DIR="$HOME/"
export XDG_DOCUMENTS_DIR="$HOME/docs/"
export XDG_DOWNLOAD_DIR="$HOME/downs/"
export XDG_PICTURES_DIR="$HOME/docs/pics/"
export XDG_RUNTIME_DIR="/run/user/$UID"

# other config
export TASKDATA=$XDG_DATA_HOME/task
export TASKRC=$XDG_CONFIG_HOME/taskwarrior/.taskrc
export ZK_DIR=/home/skovati/dev/git/vault

# rice
export BAT_THEME="ansi"
# fixes gpg-ncurses
export GPG_TTY=$(tty)

########################################
# ALIASES
########################################
alias cp="cp -v"
alias mv="mv -iv"
alias rm="rm -vI"
alias syu="doas pacman -Syu"
alias vim="nvim"
alias sudo="doas"
alias one="ping -c 5 1.1.1.1"
alias vrc="nvim ~/.config/nvim/init.lua"
alias sx="nsxiv -b -a"
alias rcp="rsync -avzhP"
alias z="zathura --fork"
alias xc="xclip -sel clipboard -i"
alias xp="xclip -sel clipboard -o"

# fancy cli tools
which exa > /dev/null 2>&1 && alias ls="exa -F" || {
    alias ls="ls --color -F"
    # make ls pretty
    LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=30;41:sg=30;43:tw=30;42:ow=30;42:st=30;44:ex=01;32:';
    export LS_COLORS
}
which zoxide > /dev/null 2>&1 && eval "$(zoxide init --cmd cd zsh)"

########################################
# CONFIG
########################################
# some sane defaults
HISTFILE="$XDG_DATA_HOME/zsh/.zsh_history"
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
# dont add commands that start with space to history
setopt HIST_IGNORE_SPACE
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

########################################
# ADDONS
########################################
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# addons config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#707070'
