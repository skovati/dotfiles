fish_add_path -a "$HOME/.local/bin"
fish_add_path -a "$HOME/.nix-profile/bin"
set -x EDITOR nvim
set -x MANPAGER "nvim +Man!"
set -x MOZ_ENABLE_WAYLAND 1
set -x BAT_THEME "ansi"
set -x GPG_TTY $(tty)
