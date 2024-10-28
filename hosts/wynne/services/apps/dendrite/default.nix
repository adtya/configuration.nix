{ config, pkgs, ... }:
{
  sops = {
    secrets = {
      "matrix/syncv3_secret" = {
        mode = "444";
        owner = config.users.users.root.name;
        inherit (config.users.users.root) group;
      };
    };
  };
  systemd.services.dendrite =
    let
      dendrite_package = pkgs.dendrite;
    in
    {
      description = "Dendrite Matrix homeserver";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      unitConfig.RequiresMountsFor = [ "/mnt/data" ];
      serviceConfig = {
        Type = "simple";
        User = "dendrite";
        Group = "dendrite";
        StateDirectory = "dendrite";
        WorkingDirectory = "/mnt/data/dendrite";
        RuntimeDirectory = "dendrite";
        RuntimeDirectoryMode = "0700";
        LimitNOFILE = 65535;
        ExecStart = ''
          ${dendrite_package}/bin/dendrite -http-bind-address 10.10.10.13:8008 -config ${./config.yaml}
        '';
        ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
        Restart = "on-failure";
      };
    };
  users.users.dendrite = {
    name = "dendrite";
    description = "Dendrite server user";
    home = "/mnt/data/dendrite";
    createHome = true;
    group = "dendrite";
    isSystemUser = true;
  };
  users.groups.dendrite = { };
}
