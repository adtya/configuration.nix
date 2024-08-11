_: {
  imports = [
    ./apps
    ./btrfs.nix
    ./ssh.nix
    ../../shared/caddy.nix
    ../../shared/frp.nix
  ];

  services.caddy = {
    virtualHosts = {
      "gateway.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 192.168.0.1:80
          tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
        '';
      };
      "ap1.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 192.168.1.1:80
          tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
        '';
      };
      "ap2.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 192.168.1.2:80
          tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
        '';
      };
      "switch.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 192.168.1.3:80
          tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
        '';
      };
      "frp.labs.adtya.xyz" = {
        extraConfig = ''
          reverse_proxy 10.10.10.1:7500
          tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
        '';
      };
    };
  };
}
