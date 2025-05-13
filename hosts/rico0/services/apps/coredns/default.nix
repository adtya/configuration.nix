{ config, pkgs, ... }:
let
  tailscaleInterface = config.services.tailscale.interfaceName;
  tailscaleIP = config.nodeconfig.facts.tailscale-ip;
  tailnetName = config.nodeconfig.facts.tailnet-name;
  zoneFile = pkgs.replaceVars ./labs.adtya.xyz { inherit tailnetName tailscaleIP; };
in
{
  services.coredns = {
    enable = true;
    config = ''
      labs.adtya.xyz:53 {
        errors
        log stdout
        bind ${tailscaleInterface}
        file ${zoneFile}
      }
      ${tailnetName}:53 {
        errors
        log stdout
        bind ${tailscaleInterface}
        forward . 100.100.100.100:53
      }
      .:53 {
        errors
        log stdout
        bind ${tailscaleInterface}
        forward . 1.1.1.1:53
      }
    '';
  };
  systemd.services.coredns = {
    after = [
      "tailscaled.service"
      "tailscaled-autoconnect.service"
    ];
    unitConfig.Requires = [ "tailscaled.service" ];
    serviceConfig.RestartSec = "5s";
  };
}
