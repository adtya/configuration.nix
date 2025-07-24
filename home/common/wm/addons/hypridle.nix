{ config, pkgs, ... }:
let
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  lock-session = "${pkgs.systemd}/bin/loginctl lock-session";
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${pkgs.procps}/bin/pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        unlock_cmd = "${pkgs.procps}/bin/pkill -USR1 hyprlock";
        before_sleep_cmd = lock-session;
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = lock-session;
        }
        {
          timeout = 420;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
