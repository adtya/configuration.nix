{
  config,
  if3,
  ...
}: {
  services = {
    caddy.virtualHosts = {
      "if3.adtya.xyz" = {
        extraConfig = ''
          root * ${if3.packages.${config.nixpkgs.system}.default}/share/web
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
      };

      "https.if3.adtya.xyz" = {
        type = "https";
        custom_domains = "if3.adtya.xyz";
        local_port = 443;
      };
    };
  };
}
