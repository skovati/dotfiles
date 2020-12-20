# if on tty1 and login, startx
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    # export important env vars 
    export PATH=/home/skovati/code/git/scripts/personal:/home/skovati/.local/bin:$PATH
    export EDITOR=/usr/bin/vim
    export BROWSER=/usr/bin/firefox
    exec startx
fi
