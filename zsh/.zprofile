#!/bin/zsh

if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [[ -z "$ZDOTDIR" ]]; then
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh/"
fi
