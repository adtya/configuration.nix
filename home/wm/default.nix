{ config, pkgs, ... }:
let
  hyprland-pkg = config.wayland.windowManager.hyprland.finalPackage;
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
      (pkgs.xdg-desktop-portal-hyprland.override { hyprland = hyprland-pkg; })
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
    configPackages = [ hyprland-pkg ];
  };
}
