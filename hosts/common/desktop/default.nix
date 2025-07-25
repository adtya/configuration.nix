{ inputs, pkgs, ... }:
{
  imports = [
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

    ./desktop.nix
    ./locale.nix
    ./security.nix
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
    preferStaticEmulators = true; # cross-arch inside podman
  };

  console.useXkbConfig = true;

  environment = {
    pathsToLink = [ "/share" ];
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

}
