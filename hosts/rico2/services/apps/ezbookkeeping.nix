{ config, ... }: {
  sops.secrets = {
    "ezbookkeeping/secrets" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };
  services.caddy.virtualHosts."money.labs.adtya.xyz" = {
    extraConfig = with config.recipes.ezbookkeeping.configuration; ''
      reverse_proxy ${server.http_addr}:${server.http_port}
      import hetzner
    '';
  };
  recipes.ezbookkeeping = {
    enable = true;
    configuration = {
      global = {
        app_name = "ezBookkeeping";
        mode = "production";
      };
      server = {
        protocol = "http";
        http_addr = "127.0.0.1";
        http_port = "8081";
        domain = "money.labs.adtya.xyz";
        root_url = "https://money.labs.adtya.xyz/";
      };
      database = {
        type = "postgres";
        host = "localhost:5432";
        user = "ezbookkeeping";
        ssl_mode = "disable";
      };
      mail = {
        enable_smtp = true;
        from_address = "ezBookkeeping <homelab@acomputer.lol>";
      };
      log = {
        mode = "console";
        level = "info";
      };
      storage = {
        type = "local_filesystem";
      };
      uuid = {
        generator_type = "internal";
      };
      duplicate_checker = {
        checker_type = "in_memory";
      };
      cron = {
        enable_remove_expired_tokens = true;
        enable_create_scheduled_transaction = true;
      };
      user = {
        enable_register = true;
        enable_email_verify = true;
        forget_password_require_email_verify = true;
      };
      data = {
        enable_export = true;
        enable_import = true;
      };
      map = {
        map_provider = "openstreetmap";
        amap_security_verification_method = "internal_proxy";
      };
      exchange_rates = {
        data_source = "international_monetary_fund";
      };
    };
    environmentFiles = [ config.sops.secrets."ezbookkeeping/secrets".path ];
  };

  systemd.services.ezbookkeeping = {
    after = [ "postgresql.service" ];
    wants = [ "postgresql.service" ];
    unitConfig.RequiresMountsFor = [ "/var/lib/private" ];
  };
}
