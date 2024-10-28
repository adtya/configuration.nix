_: {
  services.redis.servers = {
    blocky = {
      bind = "10.10.10.11";
      port = 6379;
    };
    caddy = {
      bind = "10.10.10.11";
      port = 6380;
    };
  };
}
