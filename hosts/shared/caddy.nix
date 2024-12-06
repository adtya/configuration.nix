{ config, inputs, pkgs, ... }: {
  sops = {
    secrets = {
      "caddy/env_file" = {
        mode = "400";
        owner = config.users.users.caddy.name;
        inherit (config.users.users.caddy) group;
      };
    };
  };
  services.caddy = {
    enable = true;
    package = inputs.caddy.packages.${pkgs.system}.caddy;
    email = "admin@acomputer.lol";
    globalConfig = ''
      admin ${config.nodeconfig.facts.wireguard-ip}:2019
      acme_dns hetzner {env.HETZNER_ACCESS_TOKEN}
      servers {
        metrics
      }
    '';
  };
  systemd.services.caddy = {
    serviceConfig.EnvironmentFile = config.sops.secrets."caddy/env_file".path;
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 80 443 ];
}

