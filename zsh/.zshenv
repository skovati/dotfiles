# important
export PATH=/home/skovati/dev/git/scripts:/home/skovati/.local/bin:$GOPATH/bin:$PATH
export EDITOR=/usr/bin/nvim
export GPG_TTY=$(tty)

# commented out bc of xdg-set command
# export BROWSER=/usr/bin/firefox

# config dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DESKTOP_DIR="$HOME/"
export XDG_DOCUMENTS_DIR="$HOME/docs/"
export XDG_DOWNLOAD_DIR="$HOME/downs/"
export XDG_PICTURES_DIR="$HOME/docs/pics/"

# misc
export GOPATH="/home/skovati/code/go"
# fixes matlab
export _JAVA_AWT_WM_NONREPARENTING=1

# set default bat theme
export BAT_THEME="base16"

# fzf
export FZF_DEFAULT_OPTS="--border=sharp --color=16 --preview 'bat --theme="base16" --color always {1}'"
