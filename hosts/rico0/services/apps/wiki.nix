{ inputs, pkgs, ... }:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat;
  domainName = "wiki.adtya.xyz";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      inherit logFormat;
      extraConfig = ''
        handle {
          root * ${inputs.wiki.packages.${pkgs.system}.default}/share/web
          encode gzip
          try_files {path} /index.html
          file_server
        }
      '';
    };
  };
}
