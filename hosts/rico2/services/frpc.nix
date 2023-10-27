{
  pkgs,
  secrets,
  ...
}: let
  inherit (secrets) frp_config;
in {
  services.frp = {
    enable = true;
    role = "client";
    settings = {
      "common" = {
        server_addr = "${frp_config.ip}";
        server_port = 7000;
        authentication_method = "token";
        token = "${frp_config.token}";
      };

      "ssh.rico2" = {
        type = "tcp";
        local_port = 22;
        remote_port = 6002;
      };

      "http.if3.adtya.xyz" = {
        type = "http";
        custom_domains = "if3.adtya.xyz";
        local_port = 80;
      };

      "https.if3.adtya.xyz" = {
        type = "https";
        custom_domains = "if3.adtya.xyz";
        local_port = 443;
      };
    };
  };
}
