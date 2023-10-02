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
      };
    in {
      enable = true;
      settings = {
        global = {
          server_name = "adtya.xyz";
          private_key = "/etc/dendrite/matrix_key.pem";
          inherit database;
        };
        app_service_api = {
          inherit database;
        };
        federation_api = {
          inherit database;
        };
        key_server = {
          inherit database;
        };
        media_api = {
          inherit database;
        };
        mscs = {
          inherit database;
        };
        relay_api = {
          inherit database;
        };
        room_server = {
          inherit database;
        };
        sync_api = {
          inherit database;
        };
        user_api = {
          account_database = database;
          device_database = database;
        };
      };
    };
  };
}
