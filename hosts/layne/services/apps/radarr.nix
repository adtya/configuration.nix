_: {
  services = {
    caddy.virtualHosts."radarr.labs.adtya.xyz" = {
      extraConfig = ''
        reverse_proxy 127.0.0.1:7878
        import hetzner
      '';
    };
    radarr = {
      enable = true;
      user = "mediaserver";
      group = "mediaserver";
    };
  };
  systemd.services.radarr.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
