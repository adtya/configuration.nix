{ lib, ... }: {
  imports = [ ./wireguard.nix ];
  networking = {
    hostName = "Rico1";

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi = {
        backend = "iwd";
        powersave = false;
      };
    };

    useDHCP = lib.mkDefault false;

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

  services.resolved.enable = true;
}
