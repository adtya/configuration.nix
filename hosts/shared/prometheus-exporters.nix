{ config, ... }: {
  services = {
    prometheus.exporters = {
      node = {
        enable = true;
        listenAddress = config.nodeconfig.facts.wireguard-ip;
        port = 9100;
        enabledCollectors = [ "systemd" "processes" ];
      };
      smartctl = {
        enable = true;
        listenAddress = config.nodeconfig.facts.wireguard-ip;
        port = 9633;
      };
      systemd = {
        enable = true;
        listenAddress = config.nodeconfig.facts.wireguard-ip;
        port = 9558;
      };

    };
  };
}
