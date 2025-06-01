{ lib, pkgs, ... }:
{
  services.displayManager = {
    enable = true;
    cosmic-greeter.enable = true;
  };
  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      binPath = lib.getExe pkgs.hyprland;
      prettyName = "Hyprland";
    };
  };
  environment.systemPackages = [
    pkgs.dracula-theme
    pkgs.dracula-icon-theme
    pkgs.adwaita-icon-theme
    pkgs.gnome-themes-extra
  ];
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [
          "gtk"
          "*"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
      Hyprland = {
        default = [
          "gtk"
          "Hyprland"
          "*"
        ];
      };
    };
  };
}
