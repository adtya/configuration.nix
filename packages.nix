{ pkgs, nixpkgs }:
let
  nixos-minimal = pkgs.nixos {
    imports = [ "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix" ];
    system.stateVersion = "24.11";
  };
in
{
  inherit (nixos-minimal) digitalOceanImage;
}
