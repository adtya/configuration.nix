_: {
  imports = [
    ./hardware
    ./persistence
    ./virtualisation
    ./network.nix
  ];
  system.stateVersion = "25.11";
}
