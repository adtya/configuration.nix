_: {
  imports = [
    ./apps
    ./btrfs.nix
    ./ssh.nix
    ../../shared/caddy.nix
    ../../shared/frp.nix
  ];

  services.caddy = {
    virtualHosts."frp.labs.adtya.xyz" = {
      extraConfig = ''
        reverse_proxy 10.10.10.1:7500
        tls /persist/secrets/caddy/certs/default.crt /persist/secrets/caddy/certs/default.key
      '';
    };
  };
}
