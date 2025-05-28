{ lib, ... }:
{
  imports = [ ../../shared/tailscale.nix ];

  nodeconfig.users.primary.extra-groups = [ "networkmanager" ];
  services.resolved.enable = true;
  networking = {
    nftables.enable = true;
    useDHCP = lib.mkDefault false;
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.backend = "iwd";
    };

    firewall = {
      allowedTCPPorts = [
        53317 # LocalSend
      ];
      allowedUDPPorts = [
        53317 # LocalSend
      ];
    };

    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          AddressRandomization = "network";
          EnableNetworkConfiguration = false;
        };
        Settings = {
          AutoConnect = "yes";
        };
      };
    };
  };
}
