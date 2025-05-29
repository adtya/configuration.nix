{ inputs, pkgs, ... }:
{
  imports = [
    inputs.jovian.nixosModules.default
    inputs.lix-module.nixosModules.default
    inputs.disko.nixosModules.disko

    ./boot
    ./hardware
    ./network
    ./programs
    ./services

    ./desktop.nix
    ./jovian.nix
    ./security.nix

    ../shared/locale.nix
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

  console.useXkbConfig = true;

  environment = {
    pathsToLink = [
      "/share"
    ];
    sessionVariables = {
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

  services.xserver.xkb = {
    layout = "us";
    options = "rupeesign:4";
    variant = "altgr-intl";
  };

  time.timeZone = "Asia/Kolkata";

  system = {
    switch = {
      enable = false;
      enableNg = true;
    };
    stateVersion = "25.05";
  };
}
