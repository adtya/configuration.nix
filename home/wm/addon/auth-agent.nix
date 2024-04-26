{ pkgs, ... }:
let
  agent = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
in
{
  systemd.user = {
    services.auth-agent = {
      Unit = {
        Description = "Polkit AUthentication Agent";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${agent}";
        Restart = "on-failure";
      };
    };
  };
}
