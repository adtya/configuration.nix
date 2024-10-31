{ pkgs, ... }:
let
  inherit (import ../../../../shared/caddy-helpers.nix) logFormat;
  domainName = "homepage.labs.adtya.xyz";
  homerPackage = pkgs.callPackage ./package.nix { };
in
{
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
        inherit logFormat;
        extraConfig = ''
          handle {
            root * ${homerPackage}/share/web
            encode gzip
            try_files {path} /index.html
            file_server
          }
        '';
      };
    };
  };
}
