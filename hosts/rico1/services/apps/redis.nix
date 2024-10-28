_: {
  services = {
    prometheus.exporters.redis = {
      enable = true;
      listenAddress = "127.0.0.1";
      port = 9121;
    };
    redis.servers = {
      blocky = {
        enable = true;
        bind = "10.10.10.11";
        port = 6379;
      };
      caddy = {
        enable = true;
        bind = "10.10.10.11";
        port = 6380;
      };
    };
  };
}
