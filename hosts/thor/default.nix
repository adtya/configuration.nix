_: {
  imports = [
    ./hardware
    ./persistence
    ./programs
    ./services
    ./boot.nix
    ./network.nix
  ];
  system.stateVersion = "25.11";
}
