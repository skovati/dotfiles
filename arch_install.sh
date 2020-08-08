#!/bin/bash
REPO=$(pwd)

cd $HOME/code/git

sudo pacman -S firefox bspwm sxhkd base-devel picom nitrogen redshift gvim zsh i3lock htop nfs-utils pamixer pavucontrol pulseaudio pulseaudio-alsa scrot xorg-server xorg-init xorg-xset xorg-xsetroot xss-lock --noconfirm

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

sudo chsh -s $(which zsh) $USER

yay -S polybar python-pywal tamzen-font siji-git nerd-fonts-roboto-mono --noconfirm

ln -s $REPO/vim/.vimrc $HOME/.vimrc
ln -s $REPO/zsh/.zshrc $HOME/.zshrc
ln -s $REPO/zsh/.zprofile $HOME/.zprofile
ln -s $REPO/polybar/config $HOME/.config/polybar/config
ln -s $REPO/polybar/colors $HOME/.config/polybar/colors
ln -s $REPO/polybar/modules $HOME/.config/polybar/modules
ln -s $REPO/polybar/launch.sh $HOME/.config/polybar/launch.sh
ln -s $REPO/sxhkd/sxhkdrc $HOME/.config/sxhkd/sxhkdrc
ln -s $REPO/bspwm/auto $HOME/.config/bspwm/auto
ln -s $REPO/bspwm/bspwmrc $HOME/.config/bspwm/bspwmrc
ln -s $REPO/gpg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
ln -s $REPO/picom/picom.conf $HOME/.picom.conf
ln -s $REPO/redshift/redshift.conf $HOME/.config/redshift/redshift.conf

cd $HOME/code/git
git clone https://github.com/skovati/scripts

mkdir $HOME/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions

mkdir $HOME/.fonts
git clone https://github.com/sunaku/tamzen-font .fonts/tamzen-font
xset +fp ~/.fonts/tamzen-font/bdf
xset fp rehash

