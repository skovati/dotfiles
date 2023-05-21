{ config, pkgs, ... }:

{
  imports = [ /etc/nixos/hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true; boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "think";
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  networking.extraHosts = ''
  100.99.222.8 torrent.lab
  '';

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  users.users.skovati = {
    isNormalUser = true;
    description = "skovati";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  fonts.fonts = with pkgs; [
    jetbrains-mono
    font-awesome
  ];

  environment.systemPackages = with pkgs; [
    git
    tailscale
    nfs-utils
    pinentry
    udisks
  ];
  services.tailscale.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.dbus.enable = true;
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.zsh.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "tty";
  };

  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "skovati" ];
      keepEnv = true;
      noPass = true;
    }];
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
