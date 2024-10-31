_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
in
{
  services = {
    caddy.virtualHosts."radarr.labs.adtya.xyz" = {
      inherit logFormat;
      extraConfig = ''
        reverse_proxy 127.0.0.1:7878
      '';
    };
    radarr = {
      enable = true;
      dataDir = "/mnt/data/radarr";
      user = "mediaserver";
      group = "mediaserver";
    };
  };
  systemd.services.radarr.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
