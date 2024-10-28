_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "forge.acomputer.lol";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      inherit logFormat;
      extraConfig = ''
        reverse_proxy 10.10.10.13:3000
      '';
    };
  };
}
