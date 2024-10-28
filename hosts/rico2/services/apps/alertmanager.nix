_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat tlsAcmeDnsChallenge;
  domainName = "alertmanager.labs.adtya.xyz";
in
{
  services = {
    caddy = {
      virtualHosts."${domainName}" = {
        inherit logFormat;
        extraConfig = ''
          ${tlsAcmeDnsChallenge}
          reverse_proxy 127.0.0.1:9093
        '';
      };
    };
    prometheus.alertmanager = {
      enable = true;
      listenAddress = "127.0.0.1";
      port = 9093;
      webExternalUrl = "https://${domainName}/";
      configuration = {
        route = {
          group_by = [ "alertname" ];
          group_wait = "30s";
          group_interval = "5m";
          repeat_interval = "1h";
          receiver = "web.hook";
        };
        receivers = [
          {
            name = "web.hook";
            webhook_configs = [
              { url = "http://127.0.0.1:5001/"; }
            ];
          }
        ];
        inhibit_rules = [
          {
            source_match =
              { severity = "critical"; };
            target_match =
              { severity = "warning"; };
            equal = [ "alertname" "dev" "instance" ];
          }
        ];
      };
    };
  };
}
