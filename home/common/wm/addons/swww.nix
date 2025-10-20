{
  pkgs,
  lib,
  config,
  ...
}:
let
  swww = lib.getExe pkgs.swww;
  find = lib.getExe pkgs.findutils;
  shuf = lib.getExe' pkgs.coreutils "shuf";

  wallpapers = "${config.xdg.userDirs.pictures}/Wallpapers/1440p/";
  wallpaperScript = pkgs.writeShellScriptBin "swww-img" ''
    ${swww} img -t fade --transition-duration 1 $(${find} ${wallpapers} -type f | ${shuf} -n1)
  '';
in
{
  services.swww = {
    enable = true;
    extraArgs = [
      "--format"
      "abgr"
      "--no-cache"
    ];
  };
  systemd.user = {
    services.swww-img = {
      Unit = {
        Description = "swww img";
        PartOf = [ "graphical-session.target" ];
        After = [
          "graphical-session.target"
          "swww.service"
        ];
        Requires = [ "swww.service" ];
        ConditionEnvironment = [ "WAYLAND_DISPLAY" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = lib.getExe wallpaperScript;
        Restart = "on-failure";
      };
    };
    timers.swww-img = {
      Unit = {
        Description = "swww img timer";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Timer = {
        #OnActiveSec = "600";
        OnCalendar = "*:0/10";
      };
    };
  };
}
