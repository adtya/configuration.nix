{ config, pkgs, ... }:
let
  tailscaleIP = config.nodeconfig.facts.tailscale-ip;
  tailnetName = config.nodeconfig.facts.tailnet-name;
  zoneFile = pkgs.substituteAll {
    src = ./labs.adtya.xyz;
    inherit tailnetName tailscaleIP;
  };
in
{
  services.coredns = {
    enable = true;
    config = ''
      labs.adtya.xyz:53 {
        errors
        log stdout
        bind ${tailscaleIP}
        file ${zoneFile}
      }
      ${tailnetName}:53 {
        errors
        log stdout
        bind ${tailscaleIP}
        forward . 100.100.100.100:53
      }
      .:53 {
        errors
        log stdout
        bind ${tailscaleIP}
        forward . 1.1.1.1:53
      }
    '';
  };
  systemd.services.coredns = {
    after = [ "tailscaled.service" ];
    unitConfig.Requires = [ "tailscaled.service" ];
    serviceConfig.RestartSec = "5s";
  };
}
