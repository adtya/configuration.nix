_:
let domainName = "loki.labs.adtya.xyz"; in {
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
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
