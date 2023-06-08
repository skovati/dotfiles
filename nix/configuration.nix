{ inputs, lib, config, pkgs, ... }:

{ imports = [ ./hardware-configuration.nix ];

    ########################################
    # nix meta config
    ########################################

    nixpkgs.config.allowUnfree = true;
    nix = {
        settings = {
            auto-optimise-store = true;
            warn-dirty = false;
            experimental-features = [ "nix-command" "flakes" ];
        };
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };

    ########################################
    # system config
    ########################################

    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
            systemd-boot.enable = true;
            systemd-boot.configurationLimit = 10;
            efi.canTouchEfiVariables = true;
            efi.efiSysMountPoint = "/boot/efi";
            timeout = 3;
        };
        initrd.secrets = {
            "/crypto_keyfile.bin" = null;
        };
    };

    networking = {
        hostName = "think";
        networkmanager.enable = true;
        firewall = {
            enable = true;
            allowedTCPPorts = [];
            allowedUDPPorts = [];
        };
        extraHosts = ''100.99.222.8 torrent.lab'';
    };

    time.timeZone = "America/Chicago";

    fonts = {
        fontDir.enable = true;
        fonts = with pkgs; [
            (nerdfonts.override {
                fonts = [ "JetBrainsMono" ];
            })
        ];
    };

    ########################################
    # users
    ########################################

    users.users.skovati = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "libvirtd"];
        initialPassword = "password";
        shell = pkgs.zsh;
    };

    ########################################
    # programs
    ########################################
    environment.systemPackages = with pkgs; [
        git
        nfs-utils
        pinentry
        virt-manager
    ];
    programs.zsh.enable = true;

    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
    };

    programs.gnupg.agent = {
        enable = true;
        pinentryFlavor = "tty";
    };

    programs.dconf.enable = true;
    # virtualisation.libvirtd.enable = true;

    ########################################
    # services
    ########################################
    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-wlr
        ];
    };

    services.tailscale.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
    };

    services.dbus.enable = true;
    services.flatpak.enable = true;

    security.doas = {
        enable = true;
        extraRules = [{
            users = [ "skovati" ];
            keepEnv = true;
            noPass = true;
        }];
    };

    services.tlp = {
        enable = true;
        settings = {
            WIFI_PWR_ON_BAT = "off";
            CPU_BOOST_ON_BAT = "1";
            SCHED_POWERSAVE_ON_BAT = "1";
            PLATFORM_PROFILE_ON_AC = "performance";
            PLATFORM_PROFILE_ON_BAT = "balanced";
        };
    };

    services.rpcbind.enable = true;
    systemd.mounts = [{
        type = "nfs";
        mountConfig = {
            Options = "noatime";
        };
        what = "node:/tank/media";
        where = "/media";
    }];

    systemd.automounts = [{
        wantedBy = [ "multi-user.target" ];
        automountConfig = {
            TimeoutIdleSec = "500";
        };
        where = "/media";
    }];

    # don't touch
    system.stateVersion = "22.11";
}
