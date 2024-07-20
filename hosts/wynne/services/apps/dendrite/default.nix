{ pkgs, ... }: {
  services = {
    caddy.virtualHosts."matrix.acomputer.lol" = {
      extraConfig = ''
        reverse_proxy /_matrix/* 127.0.0.1:8008
        reverse_proxy /_synapse/* 127.0.0.1:8008
      '';
    };
    frp.settings.proxies = [
      {
        name = "http.matrix.acomputer.lol";
        type = "http";
        customDomains = [ "matrix.acomputer.lol" ];
        localPort = 80;
        transport.useCompression = true;
      }
      {
        name = "https.matrix.acomputer.lol";
        type = "https";
        customDomains = [ "matrix.acomputer.lol" ];
        localPort = 443;
        transport.useCompression = true;
      }
    ];
  };
  systemd.services.dendrite = {
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
        ${pkgs.dendrite}/bin/dendrite -http-bind-address 127.0.0.1:8008 -config ${./config.yaml}
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
