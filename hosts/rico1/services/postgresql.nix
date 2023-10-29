{pkgs, ...}: {
  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local  all       all       trust
      host   dendrite  dendrite  trust
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
