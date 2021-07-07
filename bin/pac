#!/bin/sh
# wrapper for pacman that lets the user select a package using fzf

pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro doas pacman -S
