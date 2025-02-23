_: {
  fileSystems = {
    secureboot = {
      mountPoint = "/var/lib/sbctl";
      device = "/persist/secrets/secureboot";
      fsType = "none";
      options = [ "bind" ];
    };
    tailscale = {
      mountPoint = "/var/lib/tailscale";
      device = "/persist/data/tailscale";
      fsType = "none";
      options = [ "bind" ];
    };
  };
}
