{ secrets, ... }: {
  services.frp = {
    enable = true;
    role = "client";
    settings = {
      "common" = {
        inherit (secrets.frp_config) server_addr token;
        server_port = 7000;
        authentication_method = "token";
      };

      "ssh.rico0" = {
        type = "tcp";
        local_port = 22;
        remote_port = 6000;
      };
    };
  };
}
