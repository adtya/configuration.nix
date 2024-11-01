_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
in
{
  services = {
    caddy.virtualHosts."sonarr.labs.adtya.xyz" = {
      inherit logFormat;
      extraConfig = ''
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
  systemd.services.sanarr.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
