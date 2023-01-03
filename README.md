# dotfiles

## personal dotfiles for arch, sway, nvim, zsh, etc.

### screenshot
![scrot](https://user-images.githubusercontent.com/49844593/179421461-bac76855-e48e-48cc-bc0f-ca1ec35c770b.png)

### software
| program           | name                                                          |
| :---              | :---                                                          |
| distro            | [arch](https://archlinux.org/)                                |
| wm                | [swaywm](https://github.com/swaywm/sway)                      |
| launcher          | [bemenu](https://github.com/Cloudef/bemenu)                   |
| browser           | [librewolf](https://librewolf.net/)                           |
| editor            | [nvim](https://neovim.io/)                                    |
| font              | [jetbrains mono](https://github.com/JetBrains/JetBrainsMono)  |
| shell             | [zsh](https://www.zsh.org/)                                   |
| term              | [alacritty](https://github.com/alacritty/alacritty)           |
| doc viewer        | [zathura](https://pwmt.org/projects/zathura/)                 |
| colorscheme       | [cybrpnk](https://github.com/skovati/cybrpnk.nvim)            |

### installation

```sh
# install a minimal linux distro (arch, alpine, void)
git clone https://github.com/skovati/dotfiles
cd dotfiles
stow -v 2 -t $HOME */
```
