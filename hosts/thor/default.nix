_: {
  imports = [
    ./hardware
    ./persistence
    ./services
    ./virtualisation
    ./network.nix
  ];
  system.stateVersion = "25.11";
}
