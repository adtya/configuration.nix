{ lib, ... }: {
  imports = [ ./wireguard.nix ];
  networking = {
    hostName = "Skipper";

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

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        hinfo = true;
        workstation = true;
      };
    };
    resolved.enable = true;
  };
}
