{ config, pkgs, ... }:
let
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
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
          timeout = 10;
          on-timeout = "${brightnessctl} --quiet --device=dell::kbd_backlight --save set 0";
          on-resume = "${brightnessctl} --quiet --device=dell::kbd_backlight --restore";
        }
        {
          timeout = 150;
          on-timeout = "${brightnessctl} --quiet --device=intel_backlight --save set 30";
          on-resume = "${brightnessctl} --quiet --device=intel_backlight --restore";
        }
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
