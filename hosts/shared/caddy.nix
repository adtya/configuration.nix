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
      acme_dns digitalocean {env.DO_API_TOKEN}
    '';
    logFormat = "level INFO";
  };
  systemd.services.caddy.serviceConfig.EnvironmentFile = config.sops.secrets."caddy/env_file".path;
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}

