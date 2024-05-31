{ config, pkgs, ... }: {
  programs.wpaperd = {
    enable = true;
    settings = {
      default = {
        duration = "10m";
        mode = "stretch";
        sorting = "random";
        path = "${config.xdg.userDirs.pictures}/Wallpapers";
      };
    };
  };
  systemd.user.services.wpaperd = {
    Unit = {
      Description = "Modern wallpaper daemon for Wayland";
      Documentation = "https://github.com/danyspin97/wpaperd";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wpaperd}/bin/wpaperd";
      Restart = "on-failure";
      KillMode = "mixed";
    };
  };
}
