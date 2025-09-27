{ lib, config, ... }:
{
  sops = {
    secrets = {
      "ntfy/environment_file" = {
        mode = "400";
        owner = config.services.ntfy-sh.user;
        inherit (config.services.ntfy-sh) group;
      };
    };
  };
  services.ntfy-sh = {
    enable = true;
    environmentFile = config.sops.secrets."ntfy/environment_file".path;
    settings = {
      listen-http = "${config.nodeconfig.facts.tailscale-ip}:2586";
      base-url = "https://notify.ironyofprivacy.org";
      auth-file = "/var/lib/ntfy-sh/user.db";
      cache-file = "/var/lib/ntfy-sh/cache.db";
      attachment-cache-dir = "/var/lib/ntfy-sh/attachments";
      auth-default-access = "deny-all";
      auth-access = [ "*:up*:write-only" ];
      enable-login = true;
      require-login = true;
      behind-proxy = true;
    };
  };
  systemd.services.ntfy-sh = lib.mkIf config.services.ntfy-sh.enable {
    after = [
      "tailscaled.service"
      "tailscaled-autoconnect.service"
    ];
    unitConfig.Requires = [ "tailscaled.service" ];
    serviceConfig.RestartSec = "5s";
  };
}
