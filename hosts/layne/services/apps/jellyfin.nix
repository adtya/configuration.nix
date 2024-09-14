_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
in
{
  services = {
    caddy = {
      virtualHosts = {
        "jellyfin.local.adtya.xyz" = {
          logFormat = logFormat "jellyfin.local.adtya.xyz";
          extraConfig = ''
            reverse_proxy 127.0.0.1:8096
          '';
        };
        "jellyfin.labs.adtya.xyz" = {
          logFormat = logFormat "jellyfin.labs.adtya.xyz";
          extraConfig = ''
            reverse_proxy 127.0.0.1:8096
          '';
        };
      };
    };
    jellyfin = {
      enable = true;
      dataDir = "/mnt/data/Jellyfin";
      openFirewall = true;
    };
  };
  systemd.services.jellyfin.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
