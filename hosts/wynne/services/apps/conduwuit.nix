{ config, ... }: {
  sops.secrets = {
    "conduwuit/secrets" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };

  recipes.conduwuit.instances = {
    acomputer-lol = let domain = "acomputer.lol"; in {
      enable = true;
      environmentFiles = [ config.sops.secrets."conduwuit/secrets".path ];
      settings = {
        global = {
          server_name = domain;
          address = [ "10.10.10.13" ];
          port = 6167;
          database_backend = "rocksdb";
          ip_lookup_strategy = 1;

          new_user_displayname_suffix = "💯";
          allow_check_for_updates = false;
          allow_encryption = true;
          allow_federation = true;
          allow_device_name_federation = true;
          query_trusted_key_servers_first = false;
          trusted_servers = [ "matrix.org" ];
          well_known = {
            server = "matrix.${domain}:443";
            client = "https://matrix.${domain}";
          };
        };
      };
    };
    ironyofprivacy = let domain = "ironyofprivacy.org"; in {
      enable = true;
      environmentFiles = [ config.sops.secrets."conduwuit/secrets".path ];
      settings = {
        global = {
          server_name = domain;
          address = [ "10.10.10.13" ];
          port = 6168;
          database_backend = "rocksdb";
          ip_lookup_strategy = 1;

          new_user_displayname_suffix = "💯";
          allow_check_for_updates = false;
          allow_encryption = true;
          allow_federation = true;
          allow_device_name_federation = true;
          query_trusted_key_servers_first = false;
          trusted_servers = [ "matrix.org" ];
          well_known = {
            server = "matrix.${domain}:443";
            client = "https://matrix.${domain}";
          };
        };
      };
    };
  };
  systemd.services."conduwuit-ironyofprivacy".unitConfig.RequiresMountsFor = [ "/var/lib/private" ];
  systemd.services."conduwuit-acomputer-lol".unitConfig.RequiresMountsFor = [ "/var/lib/private" ];
}
