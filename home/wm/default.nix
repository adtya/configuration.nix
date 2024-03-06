{ config, pkgs, ... }:
let
  hyprland = config.wayland.windowManager.hyprland.finalPackage;
in
{
  imports = [
    ./hyprland
    ./addon
  ];
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      (xdg-desktop-portal-hyprland.override { inherit hyprland; })
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
    configPackages = [ hyprland ];
  };
}
