{
  pkgs,
  secrets,
  ...
}: let
  frp_config = secrets.frp_config;
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

    [ssh.rico2]
    type = tcp
    local_port = 22
    remote_port = 6002

    [http.adtya.xyz]
    type = http
    custom_domains = adtya.xyz
    local_port = 80

    [https.adtya.xyz]
    type = https
    custom_domains = adtya.xyz
    local_port = 443

    [http.www.adtya.xyz]
    type = http
    custom_domains = www.adtya.xyz
    local_port = 80

    [https.www.adtya.xyz]
    type = https
    custom_domains = www.adtya.xyz
    local_port = 443

    [http.proofs.adtya.xyz]
    type = http
    custom_domains = proofs.adtya.xyz
    local_port = 80

    [https.proofs.adtya.xyz]
    type = https
    custom_domains = proofs.adtya.xyz
    local_port = 443
  '';
}
