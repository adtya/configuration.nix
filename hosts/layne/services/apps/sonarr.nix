_: {
  services = {
    caddy.virtualHosts."sonarr.labs.adtya.xyz" = {
      extraConfig = ''
        reverse_proxy 127.0.0.1:8989
        import hetzner
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
