{ config, inputs, pkgs, ... }: {
  sops = {
    secrets = {
      "digitalocean/token_file" = {
        mode = "444";
        owner = config.users.users.root.name;
        group = config.users.users.root.group;
      };
    };
  };
  services.caddy = {
    enable = true;
    package = inputs.caddy.packages.${pkgs.system}.caddy;
    email = "admin@acomputer.lol";
    globalConfig = ''
      acme_dns digitalocean {env.DO_API_TOKEN}
      servers {
        metrics
      }
    '';
    logFormat = "level INFO";
  };
  systemd.services.caddy.serviceConfig.EnvironmentFile = config.sops.secrets."digitalocean/token_file".path;
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}

