_:
let domainName = "blocky.rico2.labs.adtya.xyz"; in {
  imports = [
    ../../../shared/blocky.nix
  ];
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8080
        '';
      };
    };
    blocky.settings.ports = {
      dns = "192.168.1.12:53,10.10.10.12:53";
      tls = "192.168.1.12:853,10.10.10.12:853";
      http = "127.0.0.1:8080";
    };
  };
}
