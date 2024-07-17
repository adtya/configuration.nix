_: {
  services.caddy = {
    enable = true;
    acmeCA = "https://acme-v02.api.letsencrypt.org/directory";
    email = "admin@acomputer.lol";
  };
}
