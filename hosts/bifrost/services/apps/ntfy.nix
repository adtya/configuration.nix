_:
let
  domainName = "notify.ironyofprivacy.org";
in
{
  services = {
    caddy.virtualHosts."${domainName}" = {
      extraConfig = ''
        import hetzner
        reverse_proxy 100.69.69.11:2586
      '';
    };
  };
}
