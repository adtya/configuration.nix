{ pkgs, ... }:
let
  change-wallpaper = "${pkgs.setpaper}/bin/setpaper";
  wallpaper-downloader = "${pkgs.getpaper}/bin/getpaper";
in
{
  systemd.user = {
    services = {
      wallhaven = {
        Unit = {
          Description = "Wallpaper Downloader";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session-pre.target" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${wallpaper-downloader}";
        };

      };
      wallpaper = {
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
    };
    timers = {
      wallhaven = {
        Unit = {
          Description = "Wallpaper Downloader";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
        Timer = {
          OnCalendar = "00:00:00";
          Persistent = true;
        };
      };
      wallpaper = {
        Unit = {
          Description = "Change Wallpaper";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
        Timer = {
          OnStartupSec = "10min";
          OnUnitActiveSec = "10min";
        };
      };
    };
  };
}
