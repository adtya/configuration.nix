{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")

    ./services
  ];

  nodeconfig.facts.tailscale-ip = "100.69.69.4";

  system.stateVersion = "25.11";
}
