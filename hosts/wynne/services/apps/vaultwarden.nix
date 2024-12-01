{ config, ... }: {
  sops.secrets = {
    "vaultwarden/secrets" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };

  recipes.vaultwarden = {
    enable = true;
    databaseBackend = "postgresql";
    config = {
      ROCKET_ADDRESS = config.nodeconfig.facts.wireguard-ip;
      ROCKET_PORT = "8222";
      DOMAIN = "https://vault.acomputer.lol";
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
    after = [ "wg-quick-Homelab.service" "postgresql.service" ];
    wants = [ "postgresql.service" ];
    unitConfig.RequiresMountsFor = [ "/var/lib/private" ];
  };
}
