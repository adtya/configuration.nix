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
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };
  };
}
