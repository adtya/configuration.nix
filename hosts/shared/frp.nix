{ config, lib, ... }: {
  sops.secrets = {
    "frp/token_file" = {
      mode = "400";
      owner = config.users.users.root.name;
      group = config.users.users.root.group;
    };
  };

  systemd.services.frp.serviceConfig.EnvironmentFile = config.sops.secrets."frp/token_file".path;
  systemd.services.frp.serviceConfig.Restart = lib.mkForce "always";

  services.frp = {
    enable = true;
    role = "client";
    settings = {
      serverAddr = "10.10.10.1";
      serverPort = 7002;
      transport.protocol = "quic";
      auth.method = "token";
      auth.token = "{{ .Envs.FRP_AUTH_TOKEN }}";
    };
  };
}

