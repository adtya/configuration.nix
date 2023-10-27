{
  config,
  wiki,
  ...
}: {
  services = {
    caddy.virtualHosts = {
      "wiki.adtya.xyz" = {
        extraConfig = ''
          root * ${wiki.packages.${config.nixpkgs.system}.default}/share/web
          encode gzip
          try_files {path} /index.html
          file_server
        '';
      };
    };

    frp.settings = {
      "http.wiki.adtya.xyz" = {
        type = "http";
        custom_domains = "wiki.adtya.xyz";
        local_port = 80;
      };

      "https.wiki.adtya.xyz" = {
        type = "https";
        custom_domains = "wiki.adtya.xyz";
        local_port = 443;
      };
    };
  };
}
