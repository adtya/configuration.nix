_:
let domainName = "blocky.local.adtya.xyz"; in {
  imports = [
    ../../../shared/blocky.nix
  ];
  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8080
        '';
      };
    };
    blocky.settings = {
      ports = {
        dns = "192.168.1.10:53";
        http = "127.0.0.1:8080";
      };
      conditional = {
        fallbackUpstream = false;
        mapping = {
          "local.adtya.xyz" = "192.168.1.1";
          "1.168.192.in-addr.arpa" = "192.168.1.1";
        };
      };
      clientLookup = {
        upstream = "192.168.1.1";
        singleNameOrder = [ 2 1 ];
      };
      customDNS = {
        mapping = {
          # Local (Home Network)
          "gateway.local.adtya.xyz" = "192.168.0.1";
          "ap1.local.adtya.xyz" = "192.168.1.1";
          "ap2.local.adtya.xyz" = "192.168.1.2";
          "switch.local.adtya.xyz" = "192.168.1.3";
          "jellyfin.local.adtya.xyz" = "192.168.1.14";
        };
      };
    };
  };
}
