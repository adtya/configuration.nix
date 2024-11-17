_: {
  services = {
    caddy.virtualHosts."lidarr.labs.adtya.xyz" = {
      extraConfig = ''
        reverse_proxy 127.0.0.1:8686
      '';
    };
    lidarr = {
      enable = true;
      dataDir = "/mnt/data/lidarr";
      user = "mediaserver";
      group = "mediaserver";
    };
  };
  systemd.services.lidarr.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}

