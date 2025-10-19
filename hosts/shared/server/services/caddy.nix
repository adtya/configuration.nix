{
  config,
  pkgs,
  lib,
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
    package = pkgs.caddy-custom;
    email = "admin@acomputer.lol";
    extraConfig = ''
      (hetzner) {
        tls {
          dns hetzner {env.HETZNER_ACCESS_TOKEN}
          resolvers 213.133.100.98
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
