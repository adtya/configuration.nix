_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "acomputer.lol";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      inherit logFormat;
      extraConfig = ''
        handle /.well-known/matrix/server {
          header Content-Type application/json
          header Access-Control-Allow-Origin *
          respond `{"m.server": "matrix.${domainName}:443"}`
        }

        handle /.well-known/matrix/client {
          header Content-Type application/json
          header Access-Control-Allow-Origin *
          respond `{"m.homeserver": {"base_url": "https://matrix.${domainName}:443"}}`
        }
      '';
    };
  };
}
