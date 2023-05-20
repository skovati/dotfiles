{ config, pkgs, ... }:

{
  home.username = "skovati";
  home.homeDirectory = "/home/skovati";

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
  ];

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

  programs.zsh = {
    enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    # plugins = [
    #   {
    #     name = "zsh-autosuggestions";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "zsh-users";
    #       repo = "zsh-autosuggestions";
    #       rev = "0.7.0";
    #       sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
    #     };
    #   }
    #   {
    #     name = "zsh-syntax-highlighting";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "zsh-users";
    #       repo = "zsh-syntax-highlighting";
    #       rev = "0.7.1";
    #       sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
    #     };
    #   }
    # ];
  };

  programs.git = {
    enable = true;
    userEmail = "skovati@protonmail.com";
    userName = "skovati";
    signing.key = "5026E406B7B3818F";
    signing.signByDefault = true;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
  };

  home.sessionVariables = {};

  # don't touch
  programs.home-manager.enable = true;
  home.stateVersion = "22.11";
}
