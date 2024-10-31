_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
in
{
  services = {
    caddy.virtualHosts."readarr.labs.adtya.xyz" = {
      inherit logFormat;
      extraConfig = ''
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
