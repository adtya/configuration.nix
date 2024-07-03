{ inputs, pkgs, ... }: {
  services = {
    caddy.virtualHosts."adtya.xyz" = {
      serverAliases = [ "www.adtya.xyz" ];
      extraConfig = ''
        handle {
          root * ${inputs.adtyaxyz.packages.${pkgs.system}.default}/share/web
          encode gzip
          try_files {path} /index.html
          file_server
        }
      '';
    };
    frp.settings.proxies = [
      {
        name = "http.adtya.xyz";
        type = "http";
        customDomains = [ "adtya.xyz" "www.adtya.xyz" ];
        localPort = 80;
        transport.useCompression = true;
      }
      {
        name = "https.adtya.xyz";
        type = "https";
        customDomains = [ "adtya.xyz" "www.adtya.xyz" ];
        localPort = 443;
        transport.useCompression = true;
      }
    ];
  };
}
