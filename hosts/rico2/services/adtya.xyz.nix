{
  config,
  adtya-xyz,
}: {
  services.caddy.virtualHosts."adtya.xyz" = {
    serverAliases = ["www.adtya.xyz"];
    extraConfig = ''
      handle /.well-known/matrix/server {
        header Content-Type application/json
        header Access-Control-Allow-Origin *
        respond `{"m.server": "matrix.adtya.xyz:443"}`
      }

      handle /.well-known/matrix/client {
        header Content-Type application/json
        header Access-Control-Allow-Origin *
        respond `{"m.homeserver": {"base_url": "https://matrix.adtya.xyz:443"}}`
      }

      handle {
        root * ${adtya-xyz.packages.${config.nixpkgs.system}.default}/share/web
        encode gzip
        try_files {path} /index.html
        file_server
      }
    '';
  };
}
