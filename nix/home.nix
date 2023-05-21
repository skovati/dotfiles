{ config, pkgs, ... }:

{
    home.username = "skovati";
    home.homeDirectory = "/home/skovati";

    ########################################
    # dotfiles
    ########################################

    home.file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
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
