_:
let domainName = "forge.acomputer.lol"; in {
  services = {
    caddy.virtualHosts."${domainName}" = {
      extraConfig = ''
        reverse_proxy 10.10.10.13:3000
      '';
    };
  };
}
