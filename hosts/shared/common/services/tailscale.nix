{ config, ... }:
{
  sops = {
    secrets = {
      "tailscale_auth" = {
        mode = "400";
        owner = config.users.users.root.name;
        inherit (config.users.users.root) group;
      };
    };
  };

  nodeconfig.facts.tailnet-name = "taila9bb20.ts.net";

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets."tailscale_auth".path;
    openFirewall = true;
    extraSetFlags = [
      "--webclient"
      "--ssh"
    ];
  };

  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
}
