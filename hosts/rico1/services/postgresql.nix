_: {
  services.postgresql = {
    enable = true;
    authentication = ''
      host  dendrite dendrite  127.0.0.1/32  trust
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
