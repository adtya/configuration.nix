_:
let domainName = "ironyofprivacy.org"; in {
  services = {
    caddy.virtualHosts."${domainName}" = {
      extraConfig = ''
        reverse_proxy /.well-known/matrix/* 10.10.10.13:6168
      '';
    };
  };
}

