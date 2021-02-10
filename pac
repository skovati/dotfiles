#!/usr/bin/env bash
pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro doas pacman -S
