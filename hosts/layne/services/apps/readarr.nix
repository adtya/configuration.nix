_:
let
  inherit (import ../../../shared/caddy-helpers.nix) tlsDNSChallenge;
in
{
  services = {
    caddy.virtualHosts."readarr.labs.adtya.xyz" = {
      extraConfig = ''
        ${tlsDNSChallenge}
        reverse_proxy 127.0.0.1:8787
      '';
    };
    readarr = {
      enable = true;
      dataDir = "/mnt/data/readarr";
      user = "mediaserver";
      group = "mediaserver";
    };
  };
  systemd.services.radarr.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
