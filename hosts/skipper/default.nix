{ inputs, pkgs, ... }:
{
  imports = [
    inputs.lix-module.nixosModules.default
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.home-manager.nixosModules.home-manager

    ./boot
    ./hardware
    ./network
    ./persistence
    ./programs
    ./services
    ./virtualisation
    ./security.nix

    ../shared/users.nix
  ];

  nodeconfig = {
    nix = {
      auto-optimise = true;
      is-laptop = true;
      disable-channels = true;
      cool-features = true;
      trust-wheel = true;
      enable-extra-substituters = true;
    };
    sudo = {
      enable = true;
      primary-user-is-wheel = true;
      wheel-is-god = false;
    };
  };

  # required for nixos-rebuild if target-host is of different arch. (even if --build-host is used)
  boot.binfmt = {
    emulatedSystems = [ "aarch64-linux" ];
    preferStaticEmulators = true; # cross-arch inside podman?
  };

  console.useXkbConfig = true;

  environment = {
    pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
      "/share/zsh"
    ];
    sessionVariables = {
      VDPAU_DRIVER = "va_gl";
      NIXOS_OZONE_WL = 1;
    };
  };

  fonts =
    let
      smc-fonts = inputs.smc-fonts.packages.${pkgs.system}.default;
    in
    {
      fontconfig.useEmbeddedBitmaps = true;
      packages = with pkgs; [
        cantarell-fonts
        dejavu_fonts
        liberation_ttf
        noto-fonts-cjk-sans
        noto-fonts-emoji
        nerd-fonts.fira-code
        (smc-fonts.override { fonts = [ "chilanka" ]; })
      ];
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
    supportedLocales = [
      "ml_IN/UTF-8"
      "en_IN/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
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
    config.common = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };
  };

  system = {
    switch = {
      enable = false;
      enableNg = true;
    };
    stateVersion = "23.11";
  };
}
