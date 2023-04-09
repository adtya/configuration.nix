{ pkgs, ... }: 
let
  swaylock = "${pkgs.swaylock}/bin/swaylock";
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
in
{
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${swaylock} -f -i /tmp/lockpaper.jpg";
      }
    ];
    timeouts = [
      {
        timeout = 600;
        command = "${swaylock} -f -i /tmp/lockpaper.jpg";
      }
      {
        timeout = 900;
        command = "${hyprctl} dispatch dpms off";
        resumeCommand = "${hyprctl} dispatch dpms on";
      }
    ];
  };
}
