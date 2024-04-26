{ pkgs, ... }: {
  systemd.user = {
    services.auth-agent = {
      Unit = {
        Description = "Polkit Authentication Agent";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
      };
    };
  };
}
