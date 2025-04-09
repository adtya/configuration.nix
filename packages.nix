{ pkgs, nixpkgs }:
let
  nixos-minimal-do = pkgs.nixos {
    imports = [ "${nixpkgs}/nixos/modules/virtualisation/digital-ocean-image.nix" ];
    system.stateVersion = "24.11";
  };
in
{
  inherit (nixos-minimal-do) digitalOceanImage;
}
