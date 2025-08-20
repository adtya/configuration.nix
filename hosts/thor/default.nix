{ inputs, ... }:
{
  imports = [
    inputs.chaotic.nixosModules.default

    ./hardware
    ./persistence
    ./services
    ./virtualisation
    ./boot.nix
    ./network.nix
  ];
  system.stateVersion = "25.11";
}
