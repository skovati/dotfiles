# dotfiles

## personal dotfiles for nixos, sway, nvim, zsh, etc.

### screenshot
![scrot](https://user-images.githubusercontent.com/49844593/179421461-bac76855-e48e-48cc-bc0f-ca1ec35c770b.png)

### software
| program           | name                                                          |
| :---              | :---                                                          |
| distro            | [nixos](https://nixos.org/)                                   |
| wm                | [swaywm](https://github.com/swaywm/sway)                      |
| launcher          | [bemenu](https://github.com/Cloudef/bemenu)                   |
| browser           | [librewolf](https://librewolf.net/)                           |
| editor            | [nvim](https://neovim.io/)                                    |
| font              | [jetbrains mono](https://github.com/JetBrains/JetBrainsMono)  |
| shell             | [zsh](https://www.zsh.org/)                                   |
| term              | [alacritty](https://github.com/alacritty/alacritty)           |
| doc viewer        | [zathura](https://pwmt.org/projects/zathura/)                 |

### installation

#### bootstrap
```sh
mkdir -p ~/.config/nix ~/dev/git
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
nix develop "github:skovati/dotfiles?dir=nix"
home-manager switch --flake "github:skovati/dotfiles?dir=nix#skovati"
```

#### load new hardware-configuration.nix
```sh
git clone https://github.com/skovati/dotfiles ~/dev/git/dotfiles
cp /etc/nixos/hardware-configuration.nix ~/dev/git/dotfiles/nix
doas nixos-rebuild switch --flake ~/dev/git/dotfiles/nix#think
```

### usage
```sh
update && sw && nsw
```
