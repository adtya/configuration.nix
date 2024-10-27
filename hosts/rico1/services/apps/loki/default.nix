_:
let
  inherit (import ../../../../shared/caddy-helpers.nix) logFormat tlsDNSChallenge;
  domainName = "loki.labs.adtya.xyz";
in
{
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
        logFormat = logFormat domainName;
        extraConfig = ''
          ${tlsDNSChallenge}
          reverse_proxy 127.0.0.1:3100
        '';
      };
    };
    loki = {
      enable = true;
      dataDir = "/mnt/data/loki";
      configFile = ./loki-config.yaml;
    };
  };
  systemd.services.loki.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
