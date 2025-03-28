_: {
  services = {
    caddy.virtualHosts = {
      "jellyfin.local.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8096
          import hetzner
        '';
      };
      "jellyfin.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8096
          import hetzner
        '';
      };
    };
    jellyfin = {
      enable = true;
      user = "mediaserver";
      group = "mediaserver";
    };
  };
  systemd.services.jellyfin.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
