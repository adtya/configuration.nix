{ config, lib, ... }:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "forge.acomputer.lol";
  cfg = config.services.forgejo;
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      inherit logFormat;
      extraConfig = ''
        reverse_proxy ${cfg.settings.server.HTTP_ADDR}:${toString cfg.settings.server.HTTP_PORT}
      '';
    };
    frp.settings.proxies = [
      {
        name = "http.${domainName}";
        type = "http";
        customDomains = [ "${domainName}" ];
        localPort = 80;
        transport.useCompression = true;
      }
      {
        name = "https.${domainName}";
        type = "https";
        customDomains = [ "${domainName}" ];
        localPort = 443;
        transport.useCompression = true;
      }
    ];
    forgejo = {
      enable = true;
      stateDir = "/mnt/data/Forgejo";
      settings = {
        database = {
          DB_TYPE = lib.mkForce "postgres";
          HOST = "127.0.0.1:5432";
          USER = cfg.database.user;
          NAME = cfg.database.name;
        };
        server = {
          ROOT_URL = "https://${domainName}";
          PROTOCOL = "http";
          SSH_PORT = 42069;
          HTTP_ADDR = "127.0.0.1";
          HTTP_PORT = 3000;
          DOMAIN = domainName;
        };
        session = {
          COOKIE_SECURE = true;
        };
        service = {
          DISABLE_REGISTRATION = true;
        };
      };
      database.createDatabase = true;
    };
  };
}
