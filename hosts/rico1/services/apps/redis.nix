{ config, ... }: {
  services = {
    prometheus.exporters.redis = {
      enable = true;
      listenAddress = config.nodeconfig.facts.wireguard-ip;
      port = 9121;
    };
    redis.servers = {
      default = {
        enable = true;
        bind = "10.10.10.11";
        port = 6379;
        extraParams = [ "--protected-mode no" ];
      };
    };
  };
}
