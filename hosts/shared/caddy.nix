{ inputs, pkgs, ... }: {
  services.caddy = {
    enable = true;
    acmeCA = "https://acme-v02.api.letsencrypt.org/directory";
    package = inputs.caddy.packages.${pkgs.system}.caddy;
    email = "admin@acomputer.lol";
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}

