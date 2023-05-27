{pkgs, ...}: let
  frp_config = (import ../../../secrets.nix).frp_config;
in {
  systemd.services.frpc = {
    enable = true;
    description = "FRP Client";
    wantedBy = ["multi-user.target"];
    requires = ["network.target"];
    path = [
      pkgs.frp
    ];
    script = "frpc -c /etc/frp/frpc.ini";
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
  '';
}
