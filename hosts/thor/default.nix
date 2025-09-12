_: {
  imports = [
    ./hardware
    ./persistence
    ./programs
    ./remote
    ./services
    ./boot.nix
    ./network.nix
  ];
  system.stateVersion = "25.11";
}
