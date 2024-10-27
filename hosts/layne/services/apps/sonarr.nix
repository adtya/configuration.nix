_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat tlsAcmeDnsChallenge;
in
{
  services = {
    caddy.virtualHosts."sonarr.labs.adtya.xyz" = {
      inherit logFormat;
      extraConfig = ''
        ${tlsAcmeDnsChallenge}
        reverse_proxy 127.0.0.1:8989
      '';
    };
    sonarr = {
      enable = true;
      dataDir = "/mnt/data/sonarr";
      user = "mediaserver";
      group = "mediaserver";
    };
  };
  systemd.services.radarr.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
