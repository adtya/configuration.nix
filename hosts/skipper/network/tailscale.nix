{ config, ... }: {
  sops = {
    secrets = {
      "tailscale_auth" = {
        mode = "400";
        owner = config.users.users.root.name;
        group = config.users.users.root.group;
      };
    };
  };

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets."tailscale_auth".path;
    openFirewall = true;
  };

  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
}
