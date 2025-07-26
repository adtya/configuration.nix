{ inputs, ... }:
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
    ./hardware
    ./services
    ./boot.nix
    ./network.nix
  ];
  system.stateVersion = "23.11";
}
