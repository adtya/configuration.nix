{ inputs, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  domainName = "wiki.adtya.xyz";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      extraConfig = ''
        handle {
          root * ${inputs.wiki.packages.${system}.default}/share/web
          encode gzip
          try_files {path} /index.html
          file_server
        }
      '';
    };
  };
}
