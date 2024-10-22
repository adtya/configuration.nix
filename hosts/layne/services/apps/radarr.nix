_: {
  services = {
    caddy.virtualHosts."radarr.labs.adtya.xyz" = {
      extraConfig = ''
        reverse_proxy 127.0.0.1:7878
      '';
    };
    radarr = {
      enable = true;
      dataDir = "/mnt/data/radarr";
    };
  };
  systemd.services.radarr.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
