{...}: {
  virtualisation.oci-containers.containers."adtya.xyz" = {
    image = "ghcr.io/adtya/adtya.xyz:latest";
    ports = ["3000:80"];
  };

  services.caddy.virtualHosts."adtya.xyz" = {
    serverAliases = ["www.adtya.xyz"];
    extraConfig = ''
      reverse_proxy http://127.0.0.1:3000

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
    '';
  };
}
