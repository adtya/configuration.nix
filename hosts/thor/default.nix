_: {
  imports = [
    ./hardware
    ./persistence
    ./services
    ./virtualisation
    ./boot.nix
    ./network.nix
  ];
  system.stateVersion = "25.11";
}
