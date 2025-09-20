_:
let
  domainName = "ironyofprivacy.org";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      extraConfig = ''
        import hetzner
        reverse_proxy /.well-known/matrix/* 100.69.69.11:6167
      '';
    };
  };
}
