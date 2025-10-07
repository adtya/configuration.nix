{ pkgs, ... }:
{
  systemd.user = {
    services.auth-agent = {
      Unit = {
        Description = "Polkit Authentication Agent";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        ConditionEnvironment = [ "WAYLAND_DISPLAY" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
        Restart = "on-failure";
      };
    };
  };
}
