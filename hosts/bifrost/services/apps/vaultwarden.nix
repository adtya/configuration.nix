_: {
  services.caddy.virtualHosts."vault.acomputer.lol" = {
    extraConfig = ''
      reverse_proxy 10.10.10.13:8222
    '';
  };
}
