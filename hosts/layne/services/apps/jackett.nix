_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat tlsAcmeDnsChallenge;
in
{
  services = {
    caddy.virtualHosts."jackett.labs.adtya.xyz" = {
      inherit logFormat;
      extraConfig = ''
        ${tlsAcmeDnsChallenge}
        reverse_proxy 127.0.0.1:9117
      '';
    };
    jackett = {
      enable = true;
      user = "mediaserver";
      group = "mediaserver";
      dataDir = "/mnt/data/jackett";
      port = 9117;
    };
  };
  systemd.services.radarr.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
