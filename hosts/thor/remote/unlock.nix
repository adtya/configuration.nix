_: {
  boot.initrd = {
    availableKernelModules = [ "r8169" ];
    network = {
      enable = true;
      ssh = {
        enable = true;
        port = 2222;
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPxDgoV9yf+yPnp4pt5EWgo7uC25W66ehoL/rlshVW+8 Skipper"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPodFFNUK16y9bjHVMhr+Ykro3v1FVLbmqKg7mjMv3Wz Kowalski"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPxDgoV9yf+yPnp4pt5EWgo7uC25W66ehoL/rlshVW+8 Gloria"
        ];
        hostKeys = [
          "/persist/secrets/initrd/ssh/keys/ssh_host_ed25519_key"
          "/persist/secrets/initrd/ssh/keys/ssh_host_rsa_key"
        ];
      };
    };
    systemd = {
      dbus.enable = true;
      network = {
        enable = true;
        networks."40-ether" = {
          enable = true;
          matchConfig = {
            Type = "ether";
          };
          networkConfig = {
            DHCP = "yes";
            Domains = [ "~." ];
          };
          dhcpV4Config = {
            UseDomains = true;
            RouteMetric = 100;
          };
          ipv6AcceptRAConfig = {
            RouteMetric = 100;
          };
        };
      };
    };
  };
}
