{ config, pkgs, ... }:
{
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
    package = pkgs.caddy-hetzner;
    email = "admin@acomputer.lol";
    extraConfig = ''
      (hetzner) {
        tls {
          dns hetzner {env.HETZNER_ACCESS_TOKEN}
          resolvers 1.1.1.1
        }
      }
    '';
    globalConfig = ''
      servers {
        metrics
      }
    '';
  };
  systemd.services.caddy = {
    serviceConfig.EnvironmentFile = config.sops.secrets."caddy/env_file".path;
  };
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
  networking.firewall.allowedUDPPorts = [
    80
    443
  ];
}
