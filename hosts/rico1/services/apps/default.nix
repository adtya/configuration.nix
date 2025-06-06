_: {
  services.caddy = {
    virtualHosts = {
      "gateway.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 192.168.0.1:80
        '';
      };
      "ap1.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 192.168.1.1:80
        '';
      };
      "ap2.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 192.168.1.2:80
        '';
      };
      "switch.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 192.168.1.3:80
        '';
      };
    };
  };
}
