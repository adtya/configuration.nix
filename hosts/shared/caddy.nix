{ config, inputs, pkgs, ... }:
let
  inherit (import ./caddy-helpers.nix) logFormat;
in
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
    package = inputs.caddy.packages.${pkgs.system}.caddy;
    email = "admin@acomputer.lol";
    globalConfig = ''
      servers {
        trusted_proxies static private_ranges 10.10.10.0/24
        client_ip_headers X-Forwarded-For X-Real-IP
        metrics
      }
    '';
    inherit logFormat;
  };
  systemd.services.caddy.serviceConfig.EnvironmentFile = config.sops.secrets."caddy/env_file".path;
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}

