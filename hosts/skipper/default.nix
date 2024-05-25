{ pkgs, extra-packages, ... }: {
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

  fonts = {
    fontDir.enable = true;
    packages = (with pkgs; [
      cantarell-fonts
      liberation_ttf
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ]) ++ [ extra-packages.smc-manjari ];
  };

  gtk.iconCache.enable = true;

  i18n = {
    defaultLocale = "en_IN.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN.UTF-8";
      LC_IDENTIFICATION = "en_IN.UTF-8";
      LC_MEASUREMENT = "en_IN.UTF-8";
      LC_MONETARY = "en_IN.UTF-8";
      LC_NAME = "en_IN.UTF-8";
      LC_NUMERIC = "en_IN.UTF-8";
      LC_PAPER = "en_IN.UTF-8";
      LC_TELEPHONE = "en_IN.UTF-8";
      LC_TIME = "en_IN.UTF-8";
      LC_ALL = "en_IN.UTF-8";
    };
    supportedLocales = [ "en_IN/UTF-8" "en_US.UTF-8/UTF-8" "ml_IN/UTF-8" ];
  };

  services.xserver.xkb = {
    layout = "us";
    options = "rupeesign:4";
    variant = "altgr-intl";
  };

  time.timeZone = "Asia/Kolkata";

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = [ "gtk" ];
  };

  system.stateVersion = "23.11";
}
