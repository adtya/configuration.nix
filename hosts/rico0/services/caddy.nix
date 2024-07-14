_: {
  services.caddy = {
    enable = true;
    acmeCA = "https://acme-v02.api.letsencrypt.org/directory";
    email = "admin@acomputer.lol";

    virtualHosts."frp.local.adtya.xyz" = {
      extraConfig = ''
        reverse_proxy 10.10.10.1:7500
        tls /persist/secrets/caddy/certs/frp.crt /persist/secrets/caddy/certs/frp.key
      '';
    };
  };
}
