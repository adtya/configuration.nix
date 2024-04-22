{ pkgs, ... }: {
  systemd.user.services.swww-daemon = {
    Unit = {
      Description = "Solution for Wayland Wallpaper Woes";
      Documentation = "https://github.com/LGFae/swww";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
      KillMode = "mixed";
    };
  };
}
