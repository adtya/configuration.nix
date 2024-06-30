{ pkgs, ... }: {
  imports = [
    ./boot
    ./hardware
    ./programs
    ./services
    ./network
    ./persistence
    ./virtualisation
    ./security.nix
  ];

  console.useXkbConfig = true;

  environment.sessionVariables = {
    VDPAU_DRIVER = "va_gl";
  };

  fonts = {
    packages = with pkgs; [
      cantarell-fonts
      dejavu_fonts
      liberation_ttf
      noto-fonts-cjk
      noto-fonts-emoji
      smc-chilanka
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };

  gtk.iconCache.enable = true;

  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = [ pkgs.fcitx5-varnam pkgs.fcitx5-gtk ];
      };
    };
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

  system = {
    switch = {
      enable = false;
      enableNg = true;
    };
    stateVersion = "23.11";
  };
}
