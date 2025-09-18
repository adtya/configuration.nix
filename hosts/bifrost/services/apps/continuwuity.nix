{ inputs, pkgs, ... }:
let
  domainName = "matrix.ironyofprivacy.org";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      serverAliases = [ "${domainName}:8448" ];
      extraConfig = ''
        import hetzner
        reverse_proxy 100.69.69.11:6167
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ 8448 ];
}
