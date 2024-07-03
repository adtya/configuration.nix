{ inputs, pkgs, ... }: {
  services = {
    caddy.virtualHosts."wiki.adtya.xyz" = {
      extraConfig = ''
        handle {
          root * ${inputs.wiki.packages.${pkgs.system}.default}/share/web
          encode gzip
          try_files {path} /index.html
          file_server
        }
      '';
    };
    frp.settings.proxies = [
      {
        name = "http.wiki.adtya.xyz";
        type = "http";
        customDomains = [ "wiki.adtya.xyz" ];
        localPort = 80;
        transport.useCompression = true;
      }
      {
        name = "https.wiki.adtya.xyz";
        type = "https";
        customDomains = [ "wiki.adtya.xyz" ];
        localPort = 443;
        transport.useCompression = true;
      }
    ];
  };
}
