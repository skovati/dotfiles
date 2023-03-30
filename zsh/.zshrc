#!/bin/zsh

########################################
# EXPORTS
########################################
# actually important
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.nix-profile/bin"
export EDITOR="nvim"
export VISUAL="alacritty -e 'nvim'"
export READER="zathura"
export IMAGE="nsxiv"
export TERMINAL="alacritty"
export TZ='America/Chicago'
export MANPAGER='nvim +Man!'
export MOZ_ENABLE_WAYLAND=1
export GHCUP_USE_XDG_DIRS="y"

export GOPATH="$HOME/dev/go"
export JDTLS_HOME=/usr/share/java/jdtls
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.cargo/bin:$PATH"
export _JAVA_AWT_WM_NONREPARENTING=1

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DESKTOP_DIR="$HOME/"
export XDG_DOCUMENTS_DIR="$HOME/docs/"
export XDG_DOWNLOAD_DIR="$HOME/downs/"
export XDG_PICTURES_DIR="$HOME/docs/pics/"
export XDG_RUNTIME_DIR="/run/user/$UID"
export XDG_CURRENT_DESKTOP="sway"

# purely rice
export BAT_THEME="ansi"
export GPG_TTY=$(tty)

source $HOME/.env

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
alias vrc="nvim ~/.config/nvim/init.lua ~/.config/nvim/lua/plugins.lua"
alias sx="nsxiv -b -a"
alias rcp="rsync -avzhP --stats"
alias z="zathura --fork"
alias xc="xclip -sel clipboard -i"
alias xp="xclip -sel clipboard -o"
alias em="emacsclient -c"
alias k="kubectl"
alias in="task add +in"
alias todo="task -in"

# fancy cli tools
which exa > /dev/null 2>&1 && alias ls="exa -F" || {
    alias ls="ls --color -F"
    export LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=30;41:sg=30;43:tw=30;42:ow=30;42:st=30;44:ex=01;32:'
}
which zoxide > /dev/null 2>&1 && eval "$(zoxide init --cmd cd zsh)"

########################################
# CONFIG
########################################
HISTFILE="$XDG_DATA_HOME/zsh/.zsh_history"
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt interactivecomments
unsetopt beep   # why
bindkey -v  # set vim mode

autoload -Uz compinit promptinit edit-command-line vcs_info
compinit
promptinit

# git branch in prompt
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'

zle -N edit-command-line
bindkey '\ev' edit-command-line     # open command in vim with alt-v

zstyle ":completion:*" menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey "^?" backward-delete-char

function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]]; then
        echo -ne '\e[2 q'
    elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]]; then
        echo -ne '\e[4 q'
    fi
}
zle -N zle-keymap-select

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

setopt auto_pushd

setopt prompt_subst
PROMPT=' %F{green}%~%f%F{yellow}$vcs_info_msg_0_ '

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#707070'
typeset -A ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_STYLES[comment]='fg=#707070'

########################################
# PLUGINS
########################################
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] \
    && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] \
    && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] \
    && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] \
    && source /usr/share/fzf/completion.zsh
