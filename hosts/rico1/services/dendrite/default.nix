{ pkgs, ... }: {
  services = {
    caddy.virtualHosts."matrix.adtya.xyz" = {
      extraConfig = ''
        reverse_proxy /_matrix/* 127.0.0.1:8008
        reverse_proxy /_synapse/* 127.0.0.1:8008
      '';
    };
    frp.settings = {
      "http.matrix.adtya.xyz" = {
        type = "http";
        custom_domains = "matrix.adtya.xyz";
        local_port = 80;
      };

      "https.matrix.adtya.xyz" = {
        type = "https";
        custom_domains = "matrix.adtya.xyz";
        local_port = 443;
      };

      "https.matrix.adtya.xyz.8448" = {
        type = "tcp";
        local_port = 8448;
        remote_port = 8448;
      };
    };
  };
  systemd.services.dendrite = {
    description = "Dendrite Matrix homeserver";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      DynamicUser = true;
      StateDirectory = "dendrite";
      WorkingDirectory = "/var/lib/dendrite";
      RuntimeDirectory = "dendrite";
      RuntimeDirectoryMode = "0700";
      LimitNOFILE = 65535;
      ExecStart = ''
        ${pkgs.dendrite}/bin/dendrite -http-bind-address 127.0.0.1:8008 -https-bind-address 127.0.0.1:8448 -config ${./config.yaml}
      '';
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      Restart = "on-failure";
    };
  };
}
