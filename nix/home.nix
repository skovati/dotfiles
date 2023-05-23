{ inputs, lib, config, pkgs, ... }: {

    imports = [];

    nixpkgs.config.allowUnfree = true;

    home.username = "skovati";
    home.homeDirectory = "/home/skovati";

    ########################################
    # dotfiles
    ########################################

    home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
        size = 22;
        x11.enable = true;
        x11.defaultCursor = "Adwaita";
    };

    home.file.".icons/default".source = "${pkgs.gnome.adwaita-icon-theme}/share/icons/Adwaita"; 

    gtk.cursorTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
        size = 22;
    };

    # symlink nvim config cause nix store read-only causes issues
    home.file.".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink ./nvim;
        recursive = true;
    };

    home.file.".local/bin" = {
        source = ./bin;
        recursive = true;
    };

    home.file.".gnupg/gpg.conf".source = ./gpg/gpg.conf;
    home.file.".tmux.conf".source = ./tmux/tmux.conf;

    xdg.enable = true;

    xdg.userDirs = {
        desktop = "${config.home.homeDirectory}";
        download = "${config.home.homeDirectory}/downs";
        documents = "${config.home.homeDirectory}/docs";
        music = "${config.xdg.userDirs.documents}/music";
        videos = "${config.xdg.userDirs.documents}/vids";
        pictures = "${config.xdg.userDirs.documents}/pics";
        publicShare = "${config.xdg.userDirs.documents}";
        templates = "${config.xdg.userDirs.documents}";
    };

    xdg.configFile = {
        "alacritty".source = ./alacritty;
        "mpv".source = ./mpv;
        "sway".source = /.sway;
        "zathura".source = /.zathura;
        "task".source = ./task;
    };

    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "x-scheme-handler/http" = "io.gitlab.librewolf-community.desktop";
            "x-scheme-handler/https" = "io.gitlab.librewolf-community.desktop";
            "x-scheme-handler/chrome" = "io.gitlab.librewolf-community.desktop";
            "video/mp4" = "mpv.desktop";
            "video/mkv" = "mpv.desktop";
            "image/jpeg" = "nsxiv.desktop";
            "image/jpg" = "nsxiv.desktop";
            "image/png" = "nsxiv.desktop";
            "application/epub" = "org.pwmt.zathura.desktop";
            "application/pdf" = "org.pwmt.zathura.desktop";
            "application/x-extension-htm" = "io.gitlab.librewolf-community.desktop";
            "application/x-extension-html" = "io.gitlab.librewolf-community.desktop";
            "application/x-extension-shtml" = "io.gitlab.librewolf-community.desktop";
            "application/xhtml+xml" = "io.gitlab.librewolf-community.desktop";
            "application/x-extension-xhtml" = "io.gitlab.librewolf-community.desktop";
            "application/x-extension-xht" = "io.gitlab.librewolf-community.desktop";
            "x-scheme-handler/about" = "io.gitlab.librewolf-community.desktop";
            "x-scheme-handler/unknown" = "io.gitlab.librewolf-community.desktop";
        };
        associations.added = {
            "x-scheme-handler/http" = "io.gitlab.librewolf-community.desktop";
            "x-scheme-handler/https" = "io.gitlab.librewolf-community.desktop";
            "x-scheme-handler/chrome" = "io.gitlab.librewolf-community.desktop";
            "text/html" = "io.gitlab.librewolf-community.desktop;";
            "application/x-extension-htm" = "io.gitlab.librewolf-community.desktop;";
            "application/x-extension-html" = "io.gitlab.librewolf-community.desktop;";
            "application/x-extension-shtml" = "io.gitlab.librewolf-community.desktop;";
            "application/xhtml+xml" = "io.gitlab.librewolf-community.desktop;";
            "application/x-extension-xhtml" = "io.gitlab.librewolf-community.desktop;";
            "application/x-extension-xht" = "io.gitlab.librewolf-community.desktop;";
        };
    };

    ########################################
    # programs
    ########################################

    home.packages = with pkgs; [
        ripgrep
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
        file
        pulseaudio
        brightnessctl
        mpv
        nsxiv
        kubectl
        htop
        calibre
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
        seatd
        gh
        hut
        xdg-utils
        python311Full
        python311Packages.openai
    ];

    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableSyntaxHighlighting = true;
        initExtra = builtins.readFile "../zsh/zshrc";
    };

    programs.fzf.enable = true;
    programs.zoxide.enable = true;
    programs.exa = {
        enable = true;
        enableAliases = true;
    };

    programs.git = {
        enable = true;
        userEmail = "skovati@protonmail.com";
        userName = "skovati";
        delta = {
            enable = true;
            options = {
                line-numbers = true;
                side-by-side = true;
                theme = "ansi";
            };
        };
        signing = {
            key = "skovati@protonmail.com";
            signByDefault = true;
        };
        aliases = {
            s = "status";
            c = "commit";
        };
        extraConfig = {
            pull.rebase = true;
            core.editor = "nvim";
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
