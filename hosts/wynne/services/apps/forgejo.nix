{ pkgs, config, lib, ... }:
let
  cfg = config.services.forgejo;
  domainName = "git.acomputer.lol";
in
{
  sops.secrets = {
    "forgejo/runner_registration_token_file" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };
  services = {
    gitea-actions-runner = {
      package = pkgs.forgejo-runner;
      instances = {
        x86_64-runner = {
          enable = true;
          name = "x86_64-runner";
          labels = [
            "docker:docker://ubuntu:latest"
            "x86_64-docker:docker://ubuntu:latest"
            "linux:docker://ubuntu:latest"
            "x86_64-linux:docker://ubuntu:latest"
          ];
          tokenFile = config.sops.secrets."forgejo/runner_registration_token_file".path;
          url = "https://${domainName}";
          settings = {
            log.level = "info";
            cache = {
              enabled = false;
            };
          };
        };
      };
    };
    forgejo = {
      enable = true;
      package = pkgs.forgejo;
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
          BUILTIN_SSH_SERVER_USER = "git";
          SSH_PORT = 22;
          SSH_LISTEN_PORT = 2222;
          SSH_LISTEN_HOST = "10.10.10.13";
          HTTP_ADDR = "10.10.10.13";
          HTTP_PORT = 3000;
          DOMAIN = domainName;
          LANDING_PAGE = "explore";
        };
        log = {
          LEVEL = "Warn";
          "logger.router.MODE" = "";
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
  systemd.services.forgejo.after = [ "wg-quick-Homelab.service" "postgresql.service" ];
}
