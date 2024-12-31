{ pkgs, lib, ... }:
let
  user = "mediaserver";
  group = "mediaserver";
  dataDir = "/mnt/data/prowlarr";
in
{
  services.caddy.virtualHosts."prowlarr.labs.adtya.xyz" = {
    extraConfig = ''
      reverse_proxy 127.0.0.1:9696
      import hetzner
    '';
  };
  systemd.tmpfiles.settings."10-prowlarr".${dataDir}.d = {
    inherit user group;
    mode = "0700";
  };

  systemd.services.prowlarr = {
    description = "Prowlarr";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    unitConfig.RequiresMountsFor = [ "/mnt/data" ];
    serviceConfig = {
      Type = "simple";
      User = user;
      Group = group;
      ExecStart = "${lib.getExe pkgs.prowlarr} -nobrowser -data='${dataDir}'";
      Restart = "on-failure";
    };
  };
}
