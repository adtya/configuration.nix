{ pkgs, ... }: {
  imports = [
    ./hardware
    ./programs
    ./services
    ./network.nix
    ./persistence.nix
    ./plymouth.nix
    ./rollback.nix
    ./secureboot.nix
    ./security.nix
    ./specialisations.nix
    ./virtualisation.nix
  ];

  console.useXkbConfig = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      cantarell-fonts
      liberation_ttf
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      smc-manjari
    ];
  };

  gtk.iconCache.enable = true;

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

  services.xserver.xkb = {
    layout = "us";
    options = "rupeesign:4";
    variant = "altgr-intl";
  };

  sound.enable = true;
  time.timeZone = "Asia/Kolkata";

  xdg.portal = {
    enable = true;
    config.common.default = [ "gtk" ];
  };

  system.stateVersion = "23.11";
}
