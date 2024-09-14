{ inputs, pkgs, ... }: {
  services.caddy = {
    enable = true;
    package = inputs.caddy.packages.${pkgs.system}.caddy;
    email = "admin@acomputer.lol";
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}

