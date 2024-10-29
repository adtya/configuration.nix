{ config, lib, ... }:
let
  cfg = config.services.forgejo;
  domainName = "forge.acomputer.lol";
in
{
  services = {
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
          DISABLE_SSH = false;
          START_SSH_SERVER = true;
          BUILTIN_SSH_SERVER_USER = "forge";
          SSH_PORT = 42069;
          SSH_LISTEN_HOST = "10.10.10.13";
          HTTP_ADDR = "10.10.10.13";
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
