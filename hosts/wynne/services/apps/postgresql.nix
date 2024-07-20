{ config, pkgs, ... }: {
  services = {
    prometheus.exporters.postgres = {
      enable = true;
      listenAddress = "127.0.0.1";
      port = 9187;
      runAsLocalSuperUser = true;
    };
    postgresql = {
      enable = true;
      dataDir = "/mnt/data/postgresql/${config.services.postgresql.package.psqlSchema}";
      authentication = pkgs.lib.mkOverride 10 ''
        local  all  all  trust
        host   all  all  127.0.0.1/8           trust
        host   all  all  ::1/128               trust
        host   all  all  10.10.10.0/24         trust
        host   all  all  fd7c:585c:c4ae::0/64  trust
      '';
      ensureDatabases = [ "dendrite" ];
      ensureUsers = [
      {
        name = "dendrite";
        ensureDBOwnership = true;
      }
      ];
    };
  };
  systemd.services.postgresql.unitConfig.RequiresMountsFor = [ "/mnt/data" ];
}
