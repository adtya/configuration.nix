{ config, extra-packages, ... }:
let
  wallpaper-downloader = "${extra-packages.getpaper}/bin/getpaper";
in
{
  systemd.user = {
    services = {
      getpaper = {
        Unit = {
          Description = "Wallpaper Downloader";
          After = [ "graphical-session.target" "gnome-keyring.service" ];
          Wants = "gnome-keyring.service";

        };
        Service = {
          Type = "oneshot";
          Restart = "on-failure";
          ExecStart = ''${wallpaper-downloader} "${config.xdg.userDirs.pictures}/Wallpapers"'';
        };
      };
    };
    timers = {
      getpaper = {
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
    };
  };
}
