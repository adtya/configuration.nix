{secrets, ...}: {
  services.caddy = {
    enable = true;
    inherit (secrets.caddy_config) email;
  };
}
