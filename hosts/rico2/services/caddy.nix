{ ... }: let
  caddy_config = (import ../../../secrets.nix).caddy_config;
in {
  services.caddy = {
    enable = true;
    email = caddy_config.email;
  };
}
