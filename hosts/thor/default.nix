_: {
  imports = [
    ./hardware
    ./persistence
    ./programs
    ./remote
    ./services
    ./virtualisation
    ./boot.nix
    ./network.nix
  ];
  system.stateVersion = "25.11";
}
