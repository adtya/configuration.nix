{ lib, pkgs, ... }:
let
  tomlFormat = pkgs.formats.toml { };
  walkerConfig = {
    app_launcher_prefix = "uwsm app -- ";
    disable_click_to_close = false;
    force_keyboard_focus = true;
  };
in
{
  systemd.user.services.walker = {
    Unit = {
      Description = "Walker - Application Runner";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      ConditionEnvironment = [ "WAYLAND_DISPLAY" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.walker} --gapplication-service";
      Restart = "on-failure";
    };
  };

  xdg.configFile."walker/config.toml".source = tomlFormat.generate "walker-config.toml" walkerConfig;
}
