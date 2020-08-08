if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    export PATH=/home/skovati/code/git/scripts/personal:/home/skovati/.local/bin:$PATH
    export EDITOR=/usr/bin/vim
    export BROWSER=/usr/bin/firefox
    alias ls='ls --color=auto'
    PS1='\[\033[01;32m\]\w\033[00m\] '
    exec startx
fi
