{ hyprland, impermanence, nixvim, pkgs, ... }:
let
  user = import ../users/user.nix;
in
{
  programs.fuse.userAllowOther = true;

  fileSystems."/home/${user.primary.userName}" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=0755" "uid=1000" "gid=100" ];
  };

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

    dconf.settings = {
      "io/elementary/files/preferences" = {
        "singleclick-select" = true;
      };
      "org/gtk/settings/file-chooser" = {
        "sort-directories-first" = true;
      };
    };

    xdg.enable = true;
    xdg.mime.enable = true;
    xdg.mimeApps.enable = true;
    xdg.userDirs.enable = true;

    xdg.desktopEntries."nixos-manual".name = "NixOS Manual";
    xdg.desktopEntries."nixos-manual".exec = "nixos-help";
    xdg.desktopEntries."nixos-manual".noDisplay = true;

    home.stateVersion = "23.05";
  };
}
