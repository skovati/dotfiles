if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [[ -z "$ZDOTDIR" ]]; then
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh/"
fi
# if on tty1 and login, startx
# if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#     exec startx
# fi
