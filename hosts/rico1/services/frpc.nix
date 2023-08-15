{
  pkgs,
  secrets,
  ...
}: let
  inherit (secrets) frp_config;
in {
  systemd.services.frpc = {
    enable = true;
    description = "FRP Client";
    after = ["network.target"];
    requires = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.frp}/bin/frpc -c /etc/frp/frpc.ini";
      Restart = "always";
      RestartSec = "5s";
    };
  };
  environment.etc."frp/frpc.ini".text = ''
    [common]
    server_addr = "${frp_config.ip}"
    server_port = 7000
    authentication_method = token
    token = "${frp_config.token}"

    [ssh.rico1]
    type = tcp
    local_port = 22
    remote_port = 6001
  '';
}
