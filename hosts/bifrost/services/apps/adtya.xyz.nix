{ inputs, pkgs, ... }:
let
  domainName = "adtya.xyz";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      serverAliases = [ "www.${domainName}" ];
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
