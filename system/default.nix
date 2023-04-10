{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware
    ./programs
    ./services
    ./persistence.nix
    ./plymouth.nix
    ./secureboot.nix
    ./security.nix
    ./virtualisation.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.cleanTmpDir = true;
  console.useXkbConfig = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      cantarell-fonts
      liberation_ttf
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
    };
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  location.provider = "geoclue2";

  networking = {
    hostName = "Skipper";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        powersave = false;
      };
      extraConfig = ''
        [device]
        wifi.iwd.autoconnect=yes
      '';
    };
    useDHCP = lib.mkDefault false;
    wireless.iwd.enable = true;
  };


  sound.enable = true;
  time.timeZone = "Asia/Kolkata";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-hyprland ];
  };

  system.stateVersion = "23.05";
}
