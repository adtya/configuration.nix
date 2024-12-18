{ lib, ... }:
let domainName = "ntfy.acomputer.lol"; in {
  services = {
    ntfy-sh = {
      enable = true;
      settings = {
        base-url = "https://${domainName}";
        listen-http = "10.10.10.13:8080";
        metrics-listen-http = "10.10.10.13:8081";
        auth-file = "/mnt/data/ntfy-sh/user.db";
        attachment-cache-dir = "/mnt/data/ntfy-sh/attachments";
        cache-file = "/mnt/data/ntfy-sh/cache-file.db";
        enable-login = true;

        auth-default-access = "deny-all";
      };
    };
  };
  systemd.services.ntfy-sh.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
  systemd.services.ntfy-sh.serviceConfig.WorkingDirectory = "/mnt/data/ntfy-sh";
  systemd.services.ntfy-sh.serviceConfig.User = "ntfy-sh";
  systemd.services.ntfy-sh.serviceConfig.Group = "ntfy-sh";
  systemd.services.ntfy-sh.serviceConfig.DynamicUser = lib.mkForce false;
  users.users.ntfy-sh.home = "/mnt/data/ntfy-sh";
  users.users.ntfy-sh.createHome = true;

}
