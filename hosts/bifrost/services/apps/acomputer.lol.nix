_:
let domainName = "acomputer.lol"; in {
  services = {
    caddy.virtualHosts."${domainName}" = {
      extraConfig = ''
        reverse_proxy /.well-known/matrix/* 10.10.10.13:6167
      '';
    };
  };
}
