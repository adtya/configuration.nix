{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")

    ./services
  ];

  system.stateVersion = "25.11";
}
