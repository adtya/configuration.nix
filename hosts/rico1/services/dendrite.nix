_: {
  services = {
    caddy.virtualHosts."matrix.adtya.xyz" = {
      extraConfig = ''
        reverse_proxy /_matrix/* 127.0.0.1:8008
      '';
    };
    dendrite = let
      database = {
        connection_string = "postgresql://dendrite@localhost/dendrite?sslmode=disable";
        max_open_conns = 50;
        max_idle_conns = 5;
        conn_max_lifetime = -1;
      };
    in {
      enable = false;
      settings = {
        global = {
          server_name = "adtya.xyz";
          private_key = "/etc/dendrite/matrix_key.pem";
          jetstream = {
            addresses = "localhost:4222";
          };
          inherit database;
        };
        app_service_api = {
          database = null;
        };
        federation_api = {
          database = null;
        };
        key_server = {
          database = null;
        };
        media_api = {
          database = null;
        };
        mscs = {
          database = null;
        };
        relay_api = {
          database = null;
        };
        room_server = {
          database = null;
        };
        sync_api = {
          database = null;
        };
        user_api = {
          account_database = null;
          device_database = null;
        };
      };
    };
  };
}
