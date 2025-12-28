{ inputs, pkgs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  domainName = "nix-recipes.adtya.xyz";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      extraConfig = ''
        handle {
          root * ${inputs.recipes.packages.${system}.docs-site}/
          encode gzip
          file_server
        }
      '';
    };
  };
}

