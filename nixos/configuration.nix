{ inputs, pkgs, ... }:
let
    host = {
        username = "skovati";
        hostname = "think";
    };
in { imports = [ ./hardware-configuration.nix ];

    ########################################
    # nix meta config
    ########################################

    nix = {
        settings = {
            auto-optimise-store = true;
            warn-dirty = false;
            experimental-features = [ "nix-command" "flakes" ];
        };
        gc = {
            automatic = true;
            dates = "daily";
            options = "--delete-older-than 7d";
        };
        registry.sys = {
            from = { type = "indirect"; id = "sys"; };
            flake = inputs.nixpkgs;
        };
    };
    hardware.bluetooth.enable = false;

    # rtl-sdr stuff
    boot.blacklistedKernelModules = [ "dvb_usb_rtl28xxu" "e4000" "rtl2832" ];
    users.groups.plugdev = {};

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

    # fileSystems."/media" = {
    #     device = "node:/tank/media";
    #     fsType = "nfs";
    #     options = [ "noatime "];
    # };

    networking = {
        hostName = host.hostname;
        wireless = {
            enable = true;
            userControlled.enable = true;
            interfaces = [ "wlp3s0" ];
            environmentFile = "/home/${host.username}/.env.wireless";
            networks."tebby net".psk = "@PSK_APT@";
            networks."J".psk = "@PSK_HOME@";
        };
        firewall = {
            enable = true;
            allowedTCPPorts = [8080 8000];
            allowedUDPPorts = [];
        };
        extraHosts = ''
        10.0.0.2 proxmox
        100.125.58.133 skovati.dev
        '';
    };

    time.timeZone = "America/Chicago";

    fonts = {
        fontDir.enable = true;
        packages = with pkgs; [
            noto-fonts
            noto-fonts-cjk
            noto-fonts-emoji
            (nerdfonts.override {
                fonts = [ "JetBrainsMono" ];
            })
        ];
    };

    ########################################
    # users
    ########################################

    users.users."${host.username}" = {
        isNormalUser = true;
        extraGroups = [
            "networkmanager"
            "wheel"
            "libvirtd"
            "docker"
            "adbusers"
            "plugdev"
        ];
        initialPassword = "password";
        shell = pkgs.fish;
    };

    ########################################
    # programs
    ########################################
    environment.systemPackages = with pkgs; [
        git
        nfs-utils
        pinentry
        virt-manager
        mullvad
        mullvad-vpn
        stdenv.cc.cc.lib
    ];
    programs.fish.enable = true;

    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
    };

    programs.gnupg.agent = {
        enable = true;
        pinentryFlavor = "tty";
    };

    programs.dconf.enable = true;

    virtualisation = {
        podman = {
            enable = true;
            dockerCompat = true;
        };
        libvirtd.enable = false;
    };

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

    services.mullvad-vpn.enable = true;
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

    security.sudo.enable = false;

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

    services.udev.packages = [
      pkgs.android-udev-rules
      pkgs.rtl-sdr-osmocom
    ];

    # don't touch
    system.stateVersion = "22.11";
}
