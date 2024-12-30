{ config, ... }:
let
  tailnet-name = config.nodeconfig.facts.tailnet-name;
in
{
  sops.secrets = {
    "vaultwarden/secrets" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };

  services.caddy.virtualHosts."vault.${tailnet-name}" = {
    extraConfig = with config.recipes.vaultwarden.config; ''
      reverse_proxy ${ROCKET_ADDRESS}:${ROCKET_PORT}
    '';
  };
  recipes.vaultwarden = {
    enable = true;
    databaseBackend = "postgresql";
    config = {
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = "8222";
      DOMAIN = "https://vault.${tailnet-name}";
      SIGNUPS_ALLOWED = "false";
      DATABASE_URL = "postgresql://vaultwarden@localhost/vaultwarden?sslmode=disable";
      WEB_VAULT_ENABLED = "true";
      SMTP_FROM = "vault@acomputer.lol";
      SMTP_FROM_NAME = "Vaultwarden";
      IP_HEADER = "X-Forwarded-For";
      LOG_LEVEL = "warn";
    };
    environmentFiles = [ config.sops.secrets."vaultwarden/secrets".path ];
  };
  systemd.services.vaultwarden = {
    after = [ "postgresql.service" ];
    wants = [ "postgresql.service" ];
    unitConfig.RequiresMountsFor = [ "/var/lib/private" ];
  };
}
