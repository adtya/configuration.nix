{ pkgs, lib, ... }:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  user = "mediaserver";
  group = "mediaserver";
  dataDir = "/mnt/data/bazarr";
  port = 6767;
in
{
  services.caddy.virtualHosts."bazarr.labs.adtya.xyz" = {
    inherit logFormat;
    extraConfig = ''
      reverse_proxy 127.0.0.1:${toString port}
    '';
  };
  systemd.tmpfiles.settings."10-bazarr".${dataDir}.d = {
    inherit user group;
    mode = "0700";
  };

  systemd.services.bazarr = {
    description = "Bazarr";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = user;
      Group = group;
      ExecStart = "${lib.getExe pkgs.bazarr} --port ${toString port} --config '${dataDir}'";
      Restart = "on-failure";
    };
  };
}