#!/bin/bash

REPO="/home/skovati/code/git/dotfiles"

mkdir -p /home/skovati/code/git
mkdir /home/skovati/documents

cd /home/skovati/code/git
git clone https://github.com/skovati/dotfiles

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

sudo pacman -S firefox bspwm sxhkd base-devel picom redshift vim zsh --noconfirm

sudo chsh -s $(which zsh) skovati

yay -S polybar tamzen-font siji-git oh-my-zsh-git zsh-autosuggestions nerd-fonts-roboto-mono --noconfirm

ln -s $REPO/vim/.vimrc /home/skovati/.vimrc
ln -s $REPO/zsh/* /home/skovati/*
ln -s $REPO/polybar/* /home/skovati/.config/polybar/*
ln -s $REPO/sxhkd/sxhkdrc /home/skovati/.config/sxhkd/sxhkdrc
ln -s $REPO/bspwm/* /home/skovati/.config/bspwm/*
ln -s $REPO/gpg/gpg-agent.conf /home/skovati/.gnupg/gpg-agent.conf
ln -s $REPO/picom/picom.conf /home/skovati/.picom.conf
ln -s $REPO/redshift/redshift.conf /home/skovati/.config/redshift/redshift.conf

cd /home/skovati/code/git
git clone https://github.com/skovati/scripts




