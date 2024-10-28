_:
let
  inherit (import ../../../shared/caddy-helpers.nix) logFormat tlsAcmeDnsChallenge;
in
{
  imports = [
    ./blocky.nix
    ./prometheus.nix
    ./redis.nix
    ./loki
    ../../../shared/prometheus-exporters.nix
    ../../../shared/promtail.nix
  ];
  services.caddy = {
    virtualHosts = {
      "gateway.labs.adtya.xyz" = {
        inherit logFormat;
        extraConfig = ''
          ${tlsAcmeDnsChallenge}
          reverse_proxy 192.168.0.1:80
        '';
      };
      "ap1.labs.adtya.xyz" = {
        inherit logFormat;
        extraConfig = ''
          ${tlsAcmeDnsChallenge}
          reverse_proxy 192.168.1.1:80
        '';
      };
      "ap2.labs.adtya.xyz" = {
        inherit logFormat;
        extraConfig = ''
          ${tlsAcmeDnsChallenge}
          reverse_proxy 192.168.1.2:80
        '';
      };
      "switch.labs.adtya.xyz" = {
        inherit logFormat;
        extraConfig = ''
          ${tlsAcmeDnsChallenge}
          reverse_proxy 192.168.1.3:80
        '';
      };
    };
  };
}
