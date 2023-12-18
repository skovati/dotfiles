{ lib, config, pkgs, stable-pkgs, ... }:
let
    # hacky aliases
    signal = pkgs.writeShellScriptBin "signal" ''
    org.signal.Signal "$@"
    '';

    steam = pkgs.writeShellScriptBin "steam" ''
    org.valvesoftware.Steam "$@"
    '';

    sudo = pkgs.writeScriptBin "sudo" ''exec doas "$@"'';

    browser = "librewolf.desktop";
in {

    imports = [
        ./alacritty.nix
        ./zathura.nix
        ./gpg.nix
        ./mpv.nix
        ./tmux.nix
        ./fish.nix
        ./sway.nix
    ];

    home = {
        username = "skovati";
        homeDirectory = "/home/${config.home.username}";

        # clone repo if it doesn't exist
        activation = {
            dot-clone = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            if [ ! -d ~/dev/git/dotfiles ]; then
                mkdir -p ~/dev/git
                git clone https://github.com/skovati/dotfiles ~/dev/git
            fi
            '';
        };

        pointerCursor = {
            gtk.enable = true;
            package = pkgs.gnome.adwaita-icon-theme;
            name = "Adwaita";
            size = 22;
            x11.enable = true;
            x11.defaultCursor = "Adwaita";
        };
    };

    home.file = {
        ".icons/default".source = "${pkgs.gnome.adwaita-icon-theme}/share/icons/Adwaita";

        # symlink nvim config cause nix store read-only causes issues
        ".config/nvim" = {
            source = config.lib.file.mkOutOfStoreSymlink "/home/skovati/dev/git/dotfiles/nvim/";
            recursive = true;
        };

        ".local/bin" = {
            source = ../bin;
            recursive = true;
        };
    };

    fonts.fontconfig.enable = true;

    gtk = {
        cursorTheme = {
            package = pkgs.gnome.adwaita-icon-theme;
            name = "Adwaita";
            size = 22;
        };
        theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome.adwaita-icon-theme;
        };
        iconTheme = {
            name = "Adwaita-dark";
            package = pkgs.gnome.adwaita-icon-theme;
        };
    };

    xdg = {
        enable = true;

        userDirs = {
            enable = true;
            createDirectories = true;
            desktop = "${config.home.homeDirectory}";
            download = "${config.home.homeDirectory}/downs";
            documents = "${config.home.homeDirectory}/docs";
            music = "${config.xdg.userDirs.documents}/music";
            videos = "${config.xdg.userDirs.documents}/vids";
            pictures = "${config.xdg.userDirs.documents}/pics";
            publicShare = "${config.xdg.userDirs.documents}";
            templates = "${config.xdg.userDirs.documents}";
        };

        dataHome = "${config.home.homeDirectory}/.local/share";

        mime.enable = true;

        mimeApps = {
            enable = true;
            defaultApplications = {
                "x-scheme-handler/http" = browser;
                "x-scheme-handler/https" = browser;
                "x-scheme-handler/chrome" = browser;
                "video/mp4" = "mpv.desktop";
                "video/mkv" = "mpv.desktop";
                "image/jpeg" = "nsxiv.desktop";
                "image/jpg" = "nsxiv.desktop";
                "image/png" = "nsxiv.desktop";
                "application/epub" = "org.pwmt.zathura.desktop";
                "application/pdf" = "org.pwmt.zathura.desktop";
            };
        };
    };


    home.packages =
    # unstable packages
    (with pkgs; [
        ripgrep
        fd
        firefox
        chromium
        texlive.combined.scheme-full
        deluge-gtk
        gqrx
        git
        nil
        tidal-dl
        stow
        gnupg
        luajit
        darktable
        btrfs-progs
        mods
        glow
        calibre
        pcmanfm
        newsboat
        elixir
        cargo
        rustc
        clippy
        sccache
        wayland
        glib
        grim
        emacs-all-the-icons-fonts
        ispell
        slurp
        wl-clipboard
        bemenu
        tree
        unzip
        wdisplays
        sqlite
        i3status-rust
        autotiling-rs
        pavucontrol
        easyeffects
        gcc
        zathura
        clipman
        file
        pulseaudio
        brightnessctl
        nsxiv
        kubectl
        kubernetes-helm
        android-tools
        cilium-cli
        k3d
        htop
        sumneko-lua-language-server
        temurin-bin
        jdt-language-server
        clang-tools
        gnumake
        ffmpeg
        rust-analyzer
        rustc
        gopls
        nodejs
        seatd
        gh
        hut
        xdg-utils
        p7zip
        xdg-user-dirs
        taskwarrior
        imagemagick
        jq
        yt-dlp
        librewolf
        nmap
        dwarfs
        fuse-overlayfs
        steam-run
        python3
    ]) ++
    # stable packages
    (with stable-pkgs; [
        (beets.override {
            pluginOverrides = {
                alternatives = {
                    enable = true;
                    propagatedBuildInputs = [ beetsPackages.alternatives ];
                };
            };
        })
    ]) ++
    (with pkgs; [
        nodePackages.bash-language-server
        nodePackages.typescript-language-server
        nodePackages.svelte-language-server
        nodePackages."@tailwindcss/language-server"
        nodePackages."@astrojs/language-server"
        nodePackages.vscode-langservers-extracted
        nodePackages.pnpm
    ]) ++
    # custom packages
    [
        signal
        steam
        sudo
    ];

    programs = {

        neovim = {
            enable = true;
            defaultEditor = true;
            viAlias = true;
            vimAlias = true;
            plugins = [
                pkgs.vimPlugins.nvim-treesitter.withAllGrammars
            ];
        };

        newsboat = {
            enable = true;
            extraConfig = ''
                auto-reload yes
                bind-key j down
                bind-key k up
                bind-key j next articlelist
                bind-key k prev articlelist
                bind-key G end
                bind-key g home
                bind-key a toggle-article-read
                '';
            urls = [
                { url = "https://lwn.net/headlines/newrss"; }
                { url = "https://news.ycombinator.com/rss"; }
                { url = "https://feeds.arstechnica.com/arstechnica/index/"; }
                { url = "https://willmandel.com/index.xml"; }
                { url = "https://skovati.dev/rss.xml"; }
                { url = "https://bt.ht/atom.xml"; }
                { url = "https://drewdevault.com/blog/index.xml"; }
                { url = "https://100r.co/links/rss.xml"; }
                { url = "https://what-if.xkcd.com/feed.atom"; }
                { url = "https://fasterthanli.me/index.xml"; }
                { url = "https://ciechanow.ski/atom.xml"; }
                { url = "https://waitbutwhy.com/feed"; }
            ];
        };

        emacs = {
            enable = true;
            extraPackages = epkgs: [
                epkgs.vterm
                epkgs.emacsql
            ];
        };


        fzf = rec {
            enable = true;
            defaultOptions = [
                "--preview-window sharp"
                "--preview 'bat {}'"
                "-m"
            ];
            historyWidgetOptions = ["--height 40% --preview ''"];
            defaultCommand = "fd --type f --exclude .git --ignore-file ~/.gitignore";
            fileWidgetCommand = defaultCommand;
            changeDirWidgetCommand = "fd --type d";
        };

        zoxide = {
            enable = true;
            options = [ "--cmd cd" ];
        };

        eza = {
            enable = true;
            enableAliases = true;
        };

        bat = {
            enable = true;
        };

        git = {
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

        home-manager.enable = true;

    };

    systemd.user.startServices = "sd-switch";

    services = {
        easyeffects = {
            enable = true;
        };
    };

    # don't touch
    home.stateVersion = "22.11";
}
