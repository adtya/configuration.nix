{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
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
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/hetzner@v1.0.0" ];
      hash = "sha256-XPRZbZn/8pgd2ijB3Y52M94rCHkq1TJHMb95tQxZ5bE=";
    };
    email = "admin@acomputer.lol";
    extraConfig = ''
      (hetzner) {
        tls {
          dns hetzner {env.HETZNER_ACCESS_TOKEN}
          resolvers 1.1.1.1
        }
      }
    '';
  };
  systemd.services.caddy = lib.mkIf config.services.caddy.enable {
    serviceConfig.EnvironmentFile = config.sops.secrets."caddy/env_file".path;
    after = [
      "tailscaled.service"
      "tailscaled-autoconnect.service"
    ];
    unitConfig.Requires = [ "tailscaled.service" ];
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
