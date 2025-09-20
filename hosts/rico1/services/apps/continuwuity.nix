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

        new_user_displayname_suffix = "🔥";
        require_auth_for_profile_requests = true;
        allow_device_name_federation = true;
        trusted_servers = [
          "matrix.org"
          "poddery.com"
          "frei.chat"
        ];
        query_trusted_key_servers_first = false;

        well_known = {
          client = "https://matrix.ironyofprivacy.org";
          server = "matrix.ironyofprivacy.org:443";
        };
      };
    };
  };
}
