_: {
  services.postgresql = {
    enable = true;
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
