_: {
  services = {
    caddy.virtualHosts = {
      "matrix.acomputer.lol" = {
        serverAliases = [ "matrix.acomputer.lol:8448" ];
        extraConfig = ''
          reverse_proxy /_matrix/* 10.10.10.13:6167
          reverse_proxy /_conduwuit/* 10.10.10.13:6167
          reverse_proxy /.well-known/matrix/* 10.10.10.13:6167
        '';
      };
      "matrix.ironyofprivacy.org" = {
        serverAliases = [ "matrix.ironyofprivacy.org:8448" ];
        extraConfig = ''
          reverse_proxy /_matrix/* 10.10.10.13:6168
          reverse_proxy /_conduwuit/* 10.10.10.13:6168
          reverse_proxy /.well-known/matrix/* 10.10.10.13:6168
        '';
      };
    };
  };
  networking.firewall.interfaces.ens3.allowedTCPPorts = [ 8448 ];
}
