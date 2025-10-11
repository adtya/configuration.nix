{ lib, pkgs, ... }:
{
  services.displayManager = {
    enable = true;
    gdm = {
      enable = true;
      wayland = true;
    };
  };
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        binPath = lib.getExe pkgs.hyprland;
        prettyName = "Hyprland";
      };
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
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [
          "gtk"
          "*"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
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
