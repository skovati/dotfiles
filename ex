#!/usr/bin/env bash
case $1 in
    *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) tar xjvf $1;;
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz|*.txz) tar xJvf $1;;
    *.tar) tar xvf $1;;
    *.zip) unzip $1;;
    *.rar) unrar x $1;;
    *.7z) 7z x $1;;
    *) echo "File type .$(echo $1 | cut -d. -f2) not supported, try manually..."
esac
