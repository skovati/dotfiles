{ config, pkgs, ... }:

{
    home.username = "skovati";
    home.homeDirectory = "/home/skovati";

    ########################################
    # dotfiles
    ########################################

    home.file."./.config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/skovati/dev/git/dotfiles/nvim";
        recursive = true;
    };

    xdg.enable = true;
    xdg.configFile = {
        "alacritty".source = "/home/skovati/dev/git/dotfiles/alacritty";
        #"nvim".source = "/home/skovati/dev/git/dotfiles/nvim";
    };

    ########################################
    # programs
    ########################################

    home.packages = with pkgs; [
        ripgrep
        fzf
        fd
        git
        sway
        neovim
        zsh
        stow
        gnupg
        alacritty
        wayland
        glib
        swaylock
        swayidle
        grim
        slurp
        wl-clipboard
        bemenu
        wdisplays
        i3status-rust
        autotiling-rs
        doas
        pavucontrol
        easyeffects
        gcc
        clipman
        pulseaudio
        brightnessctl
        mpv
        kubectl
        htop
        calibre
        zoxide
        exa
        sumneko-lua-language-server
        temurin-bin
        jdt-language-server
        clang-tools
        gnumake
        rust-analyzer
        rustc
        gopls
        nodejs
        nodePackages.bash-language-server
    ];

    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableSyntaxHighlighting = true;
        initExtra = builtins.readFile "/home/skovati/dev/git/dotfiles/zsh/.zshrc";
    };

    programs.fzf.enable = true;

    programs.git = {
        enable = true;
        userEmail = "skovati@protonmail.com";
        userName = "skovati";
        signing.key = "5026E406B7B3818F";
        signing.signByDefault = true;
        aliases = {
            s = "status";
            c = "commit";
        };
    };

    programs.home-manager.enable = true;

    ########################################
    # services
    ########################################

    services.gpg-agent = {
        enable = true;
        defaultCacheTtl = 1800;
    };

    home.sessionVariables = {};

    # don't touch
    home.stateVersion = "22.11";
}
