{ hyprland, impermanence, nixvim, pkgs, ... }:
let
  user = (import ../secrets.nix).users;
in
{
  programs.fuse.userAllowOther = true;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.${user.primary.userName} = { pkgs, ... }: {
    imports = [
      impermanence.nixosModules.home-manager.impermanence
      nixvim.homeManagerModules.nixvim
      hyprland.homeManagerModules.default

      ./gtk.nix
      ./persistence.nix
      ./wm
      ./programs
      ./services
    ];

    xdg.enable = true;
    xdg.mime.enable = true;
    xdg.mimeApps.enable = true;
    xdg.userDirs.enable = true;

    xdg.desktopEntries."nixos-manual" = {
      name = "NixOS Manual";
      exec = "nixos-help";
      noDisplay = true;
    };

    home.stateVersion = "23.05";
  };
}
