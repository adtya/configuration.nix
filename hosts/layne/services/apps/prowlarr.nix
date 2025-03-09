{ pkgs, lib, ... }:
let
  user = "mediaserver";
  group = "mediaserver";
in
{
  services.caddy.virtualHosts."prowlarr.labs.adtya.xyz" = {
    extraConfig = ''
      reverse_proxy 127.0.0.1:9696
      import hetzner
    '';
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
      StateDirectory = "prowlarr";
      StateDirectoryMode = "0700";
      ExecStart = "${lib.getExe pkgs.prowlarr} -nobrowser -data='/var/lib/prowlarr'";
      Restart = "on-failure";
    };
  };
}
