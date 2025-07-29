{ pkgs, config, ... }:
let
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  lock-session = "${pkgs.systemd}/bin/loginctl lock-session";
in
{
  services.hypridle.settings = {
    listener = [
      {
        timeout = 600;
        on-timeout = lock-session;
      }
      {
        timeout = 900;
        on-timeout = "${hyprctl} dispatch dpms off";
        on-resume = "${hyprctl} dispatch dpms on";
      }
      {
        timeout = 1200;
        on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

}
