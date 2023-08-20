_: {
  services = {
    caddy.virtualHosts."matrix.adtya.xyz" = {
      extraConfig = ''
        reverse_proxy /_matrix/* 127.0.0.1:8008
      '';
    };
    dendrite = {
      enable = true;
      settings = {
        global = {
          server_name = "adtya.xyz";
          private_key = "/etc/dendrite/matrix_key.pem";
          database = {
            connection_string = "postgresql://dendrite@localhost/dendrite?sslmode=disable";
          };
        };
      };
    };
  };
}
