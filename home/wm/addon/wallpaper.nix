{ config, pkgs, ... }:
let
  pictures = "${config.xdg.userDirs.pictures}";
  change-wallpaper = "${pkgs.scripts}/bin/chpaper ${pictures}/Wallpapers";
in
{
  systemd.user = {
    services.wallpaper = {
      Unit = {
        Description = "Change Wallpaper";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
        Wants = "swww-daemon.service";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${change-wallpaper}";
      };
    };
    timers.wallpaper = {
      Unit = {
        Description = "Change Wallpaper";
      };
      Timer = {
        OnStartupSec = "10min";
        OnUnitActiveSec = "10min";
      };
    };
  };
}
