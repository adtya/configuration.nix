_: {
  services = {
    caddy = {
      virtualHosts."loki.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:3100
        '';
      };
    };
    loki = {
      enable = true;
      dataDir = "/mnt/data/loki";
      configFile = ./loki-config.yaml;
    };
  };
  systemd.services.loki.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
