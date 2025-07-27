{ inputs, ... }:
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
    ./hardware
    ./services
    ./boot.nix
    ./network.nix
  ];
  nodeconfig.nix.is-laptop = true;

  system.stateVersion = "23.11";
}
