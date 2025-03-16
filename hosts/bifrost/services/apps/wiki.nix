{ inputs, pkgs, ... }:
let
  domainName = "wiki.adtya.xyz";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
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
