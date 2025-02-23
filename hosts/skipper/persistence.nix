_:
let
  bindMount = source: target: {
    device = source;
    mountPoint = target;
    fsType = "none";
    options = [ "bind" ];
  };
in
{
  fileSystems = {
    secureboot = bindMount "/persist/secrets/secureboot" "/var/lib/sbctl";
    tailscale = bindMount "/persist/data/tailscale" "/var/lib/tailscale";
  };
}
