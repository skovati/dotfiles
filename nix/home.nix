{ inputs, lib, config, pkgs, ... }:
let
    # hacky aliases
    signal = pkgs.writeShellScriptBin "signal" ''
    org.signal.Signal "$@"
    '';

    jdtls = pkgs.writeShellScriptBin "jdtls" ''
    jdt-language-server "$@"
    '';

    ec = pkgs.writeShellScriptBin "ec" ''
    emacsclient -c "$@"
    '';

    browser = "librewolf.desktop";
in {

    imports = [];

    nixpkgs.config.allowUnfree = true;

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

        # symlink nvim config cause nix store read-only causes issues
        ".config/doom" = {
            source = config.lib.file.mkOutOfStoreSymlink "/home/skovati/dev/git/dotfiles/doom/";
            recursive = true;
        };

        ".local/bin" = {
            source = ../bin;
            recursive = true;
        };

        ".gnupg/gpg.conf".source = ../gpg/gpg.conf;
        ".tmux.conf".source = ../tmux/tmux.conf;
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

        configFile = {
            "alacritty".source = ../alacritty;
            "mpv".source = ../mpv;
            "sway".source = ../sway;
            "zathura".source = ../zathura;
            "task".source = ../task;
        };

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

    home.packages = with pkgs; [
        ripgrep
        fd
        firefox
        chromium
        texlive.combined.scheme-full
        deluge-gtk
        gqrx
        git
        sway
        zsh
        nil
        tidal-dl
        stow
        gnupg
        luajit
        darktable
        btrfs-progs
        mods
        glow
        alacritty
        calibre
        pcmanfm
        newsboat
        elixir
        cargo
        rustc
        clippy
        sccache
        tmux
        wayland
        glib
        grim
        emacs-all-the-icons-fonts
        ec
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
        doas
        pavucontrol
        easyeffects
        gcc
        zathura
        clipman
        file
        pulseaudio
        brightnessctl
        mpv
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
        rust-analyzer
        rustc
        gopls
        nodejs
        nodePackages.bash-language-server
        nodePackages.typescript-language-server
        nodePackages.svelte-language-server
        nodePackages."@tailwindcss/language-server"
        nodePackages."@astrojs/language-server"
        nodePackages.vscode-langservers-extracted
        nodePackages.pnpm
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
        signal
        nmap
        dwarfs
        fuse-overlayfs
        steam-run
        (python3.withPackages (p: with p; [ openai ]))
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

        zsh = {
            enable = true;
            enableAutosuggestions = true;
            syntaxHighlighting.enable = true;
            initExtra = builtins.readFile ../zsh/zshrc;
        };

        fzf.enable = true;

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

        swaylock = {
            enable = true;
            settings = {
                no-unlock-indicator = true;
                color = "0d686b";
            };
        };

        home-manager.enable = true;

    };

    wayland.windowManager.sway = {
        enable = true;
    };

    services = {

        emacs = {
            enable = true;
        };

        gpg-agent = {
            enable = true;
            pinentryFlavor = "tty";
            grabKeyboardAndMouse = false;
        };

        swayidle = {
            enable = true;
            events = [{
                event = "before-sleep";
                command = "${pkgs.swaylock}/bin/swaylock";
            }];
            timeouts = [
                {
                    timeout = 600;
                    command = "${pkgs.swaylock}/bin/swaylock";
                }
                {
                    timeout = 900;
                    command = ''swaymsg "output * power off"'';
                    resumeCommand = ''swaymsg "output * power on"'';
                }
            ];
        };

        gammastep = {
            enable = true;
            latitude = 45.0;
            longitude = -90.0;
        };

        easyeffects = {
            enable = true;
        };

    };

    # don't touch
    home.stateVersion = "22.11";
}
