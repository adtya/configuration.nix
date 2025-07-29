{ pkgs, config, ... }:
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
    };
  };
}
