_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "blocky.rico1.labs.adtya.xyz";
in
{
  imports = [
    ../../../shared/blocky.nix
  ];
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
        inherit logFormat;
        extraConfig = ''
          reverse_proxy 127.0.0.1:8080
        '';
      };
    };
    blocky.settings.ports = {
      dns = "192.168.1.11:53,10.10.10.11:53";
      tls = "192.168.1.11:853,10.10.10.11:853";
      http = "127.0.0.1:8080";
    };
  };
}
