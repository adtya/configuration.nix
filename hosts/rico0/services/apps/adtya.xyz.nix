{ inputs, pkgs, ... }:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "adtya.xyz";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      serverAliases = [ "www.${domainName}" ];
      inherit logFormat;
      extraConfig = ''
        handle {
          root * ${inputs.adtyaxyz.packages.${pkgs.system}.default}/share/web
          encode gzip
          try_files {path} /index.html
          file_server
        }
      '';
    };
  };
}
