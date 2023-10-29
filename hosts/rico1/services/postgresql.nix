_: {
  services.postgresql = {
    enable = true;
    authentication = ''
      local dendrite dendrite  trust
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
