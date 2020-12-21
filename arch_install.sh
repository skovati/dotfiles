#!/bin/bash
REPO=$(pwd)

cd $HOME/code/git
sudo pacman -S --noconfirm --needed - < $REPO/etc/pacman.deps

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

sudo chsh -s $(which zsh) $USER

yay -S --noconfirm - < $REPO/etc/aur.deps

mkdir -p $HOME/.config/polybar
mkdir $HOME/.config/bspwm
mkdir $HOME/.config/sxhkd
mkdir $HOME/.gnupg
mkdir $HOME/.config/redshift

ln -s $REPO/vim/.vimrc $HOME/.vimrc
ln -s $REPO/zsh/.zshrc $HOME/.zshrc
ln -s $REPO/zsh/.zprofile $HOME/.zprofile
ln -s $REPO/zsh/.zsh_alias $HOME/.zsh_alias
ln -s $REPO/polybar/config $HOME/.config/polybar/config
ln -s $REPO/polybar/colors $HOME/.config/polybar/colors
ln -s $REPO/polybar/modules $HOME/.config/polybar/modules
ln -s $REPO/polybar/launch.sh $HOME/.config/polybar/launch.sh
ln -s $REPO/sxhkd/sxhkdrc $HOME/.config/sxhkd/sxhkdrc
ln -s $REPO/bspwm/auto $HOME/.config/bspwm/auto
ln -s $REPO/bspwm/bspwmrc $HOME/.config/bspwm/bspwmrc
ln -s $REPO/gpg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf

cd $HOME/code/git
git clone https://github.com/skovati/scripts

mkdir $HOME/.zsh

mkdir $HOME/.fonts
git clone https://github.com/sunaku/tamzen-font .fonts/tamzen-font
xset +fp ~/.fonts/tamzen-font/bdf
xset fp rehash

mkdir -p $HOME/documents/pictures
cd $HOME/documents/pictures
wget https://papes.skovati.com/nature/water.png
feh --bg-scale $HOME/documents/pictures
