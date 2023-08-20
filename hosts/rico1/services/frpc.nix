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

    [http.matrix.adtya.xyz]
    type = http
    custom_domains = matrix.adtya.xyz
    local_port = 80

    [https.matrix.adtya.xyz]
    type = https
    custom_domains = matrix.adtya.xyz
    local_port = 443

    [https.matrix.adtya.xyz.8448]
    type = tcp
    local_port = 8448
    remote_port = 8448
  '';
}
