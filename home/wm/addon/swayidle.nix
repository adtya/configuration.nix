{ config, ... }:
let
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
in
{
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${swaylock} -f -i /tmp/wallpaper.jpg";
      }
    ];
    timeouts = [
      {
        timeout = 600;
        command = "${swaylock} -f -i /tmp/wallpaper.jpg";
      }
      {
        timeout = 900;
        command = "${hyprctl} dispatch dpms off";
        resumeCommand = "${hyprctl} dispatch dpms on";
      }
    ];
  };
}
