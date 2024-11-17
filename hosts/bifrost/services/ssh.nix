{ config, ... }:
let facts = config.nodeconfig.facts; in {
  networking.firewall.interfaces.ens3.allowedTCPPorts = [ 22 ];
  services.openssh = {
    enable = true;
    openFirewall = false;
    listenAddresses = [
      { addr = facts.wireguard-ip; port = 22; }
      { addr = facts.local-ip; port = 22; }
    ];
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
    hostKeys = [
      {
        path = "/persist/secrets/ssh/keys/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        path = "/persist/secrets/ssh/keys/ssh_host_rsa_key";
        type = "rsa";
        bits = "4096";
      }
    ];
  };
}
