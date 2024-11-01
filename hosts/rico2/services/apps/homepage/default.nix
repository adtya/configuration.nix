{config, ...}:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "homepage.labs.adtya.xyz";
  cfg = config.services.glance;
in
{
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
        inherit logFormat;
        extraConfig = ''
          reverse_proxy ${cfg.settings.server.host}:${cfg.settings.server.port}
        '';
      };
    };
    glance = {
      enable = true;
      settings = {
        server = {
          host = "127.0.0.1";
          port = "5678";
        };
      };
    };
  };
}
