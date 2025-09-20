{ config, ... }:
{
  sops = {
    secrets = {
      "continuwuity/registration_token" = {
        mode = "400";
        owner = config.services.matrix-continuwuity.user;
        inherit (config.services.matrix-continuwuity) group;
      };
    };
  };
  services.matrix-continuwuity = {
    enable = true;
    settings = {
      global = {
        server_name = "ironyofprivacy.org";
        address = [ config.nodeconfig.facts.tailscale-ip ];
        allow_registration = true;
        registration_token_file = config.sops.secrets."continuwuity/registration_token".path;

        require_auth_for_profile_requests = true;

        well_known = {
          client = "https://matrix.ironyofprivacy.org";
          server = "matrix.ironyofprivacy.org:443";
        };
      };
    };
  };
}
