{ config, pkgs, hyprland, ... }:
let
  hyprland-pkg = config.wayland.windowManager.hyprland.finalPackage;
  xdph = hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
in
{
  imports = [
    ./hyprland
    ./addon
  ];
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      (xdph.override { hyprland = hyprland-pkg; })
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
    configPackages = [ hyprland-pkg ];
  };
}
