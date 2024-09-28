{ lib, config, pkgs, ... }:
let
  configFile = pkgs.substituteAll {
    src = ./config/eww.yuck;
    test_string = "Testing Out Eww!";
  };

  cssFile = ./config/eww.scss;

  configDir = _: pkgs.stdenvNoCC.mkDerivation {
    name = "eww-config";

    srcs = [ configFile cssFile ];
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out
      for src in $srcs; do
        cp "$src" $out/$(stripHash "$src")
      done
    '';
  };
in
{
  programs.eww = {
    enable = true;
    configDir = pkgs.callPackage configDir { };
  };
  systemd.user.services = {
    eww = {
      Unit = {
        Description = "ElKowars wacky widgets - daemon";
        Documentation = "https://elkowar.github.io/eww/";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${lib.getExe config.programs.eww.package} daemon --no-daemonize --logs";
        Restart = "on-failure";
        KillMode = "mixed";
      };
    };
    eww-widgets = {
      Unit = {
        Description = "ElKowars wacky widgets";
        Documentation = "https://elkowar.github.io/eww/";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
        Requires = [ "eww.service" ];
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${lib.getExe config.programs.eww.package} open activate-notice";
      };
    };
  };
}
