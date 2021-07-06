# important exports
export PATH=/home/skovati/dev/git/scripts:/home/skovati/.local/bin:/home/skovati/dev/go/bin:$GOPATH/bin:$PATH
export EDITOR="nvim"
export READER="zathura"
export IMAGE="sxiv"
export TERMINAL="alacritty"

# unused bc of xdg-set command
export BROWSER="firefox"

# export xdg dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DESKTOP_DIR="$HOME/"
export XDG_DOCUMENTS_DIR="$HOME/docs/"
export XDG_DOWNLOAD_DIR="$HOME/downs/"
export XDG_PICTURES_DIR="$HOME/docs/pics/"

# misc
export GOPATH="/home/skovati/dev/go"
# fixes matlab lol
export _JAVA_AWT_WM_NONREPARENTING=1
# fixes gpg-ncurses
export GPG_TTY=$(tty)

# set default bat theme
export BAT_THEME="base16"

# fzf
export FZF_DEFAULT_OPTS="--border=sharp --color=16 --preview 'bat --theme="base16" --color always {1}'"

# set manpager to nvim
# export MANPAGER="nvim -c 'set ft=man' -"
export MANPAGER="sh -c 'col -bx | bat --color=always -l man -p'"
