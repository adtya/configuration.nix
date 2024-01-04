{ pkgs
, if3
, ...
}:
let
  inherit (pkgs) system;
in
{
  services = {
    caddy.virtualHosts = {
      "if3.adtya.xyz" = {
        extraConfig = ''
          root * ${if3.packages.${system}.default}/share/web
          encode gzip
          try_files {path} /index.html
          file_server
        '';
      };
    };

    frp.settings = {
      "http.if3.adtya.xyz" = {
        type = "http";
        custom_domains = "if3.adtya.xyz";
        local_port = 80;
        proxy_protocol_version = "v2";
      };

      "https.if3.adtya.xyz" = {
        type = "https";
        custom_domains = "if3.adtya.xyz";
        local_port = 443;
        proxy_protocol_version = "v2";
      };
    };
  };
}
