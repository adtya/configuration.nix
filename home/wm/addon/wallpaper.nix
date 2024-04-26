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
      Install = {
        WantedBy = [ "graphical-session.target" ];
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
      Install = {
        WantedBy = [ "default.target" ];
      };
      Timer = {
        OnStartupSec = "15sec";
        OnUnitActiveSec = "15sec";
      };
    };
  };
}
