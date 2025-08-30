_: {
  imports = [
    ./hardware
    ./persistence
    ./services
    ./boot.nix
    ./network.nix
  ];
  system.stateVersion = "25.11";
}
