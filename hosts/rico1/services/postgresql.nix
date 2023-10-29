{pkgs, ...}: {
  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local  all  all  trust
      host   all  all  127.0.0.1/32  trust
      host   all  all  ::1/128       trust
    '';
    ensureDatabases = ["dendrite"];
    ensureUsers = [
      {
        name = "dendrite";
        ensurePermissions = {
          "DaTABASE dendrite" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
