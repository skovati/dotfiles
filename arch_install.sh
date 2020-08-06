#!/bin/bash
USER=$(whoami)
REPO=$(pwd)

mkdir -p /home/$USER/code/git
mkdir /home/$USER/documents

cd /home/$USER/code/git

sudo pacman -S firefox bspwm sxhkd base-devel picom nitrogen redshift vim zsh --noconfirm

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

sudo chsh -s $(which zsh) $USER

yay -S polybar python-pywal tamzen-font siji-git oh-my-zsh-git zsh-autosuggestions nerd-fonts-roboto-mono --noconfirm

ln -s $REPO/vim/.vimrc /home/$USER/.vimrc
ln -s $REPO/zsh/* /home/$USER/*
ln -s $REPO/polybar/* /home/$USER/.config/polybar/*
ln -s $REPO/sxhkd/sxhkdrc /home/$USER/.config/sxhkd/sxhkdrc
ln -s $REPO/bspwm/* /home/$USER/.config/bspwm/*
ln -s $REPO/gpg/gpg-agent.conf /home/$USER/.gnupg/gpg-agent.conf
ln -s $REPO/picom/picom.conf /home/$USER/.picom.conf
ln -s $REPO/redshift/redshift.conf /home/$USER/.config/redshift/redshift.conf

cd /home/$USER/code/git
git clone https://github.com/skovati/scripts




