{pkgs, ...}: {
  services = {
    caddy.virtualHosts."matrix.adtya.xyz" = {
      extraConfig = ''
        reverse_proxy /_matrix/* 127.0.0.1:8008
      '';
    };
  };
  systemd.services.dendrite = {
    description = "Dendrite Matrix homeserver";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      LimitNOFILE = 65535;
      ExecStart = ''
        ${pkgs.dendrite}/bin/dendrite -http-bind-address 127.0.0.1:8008 -https-bind-address 127.0.0.1:8448 -config ${./config.yaml}
      '';
    };
  };
}
