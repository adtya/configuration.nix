_:
let
  inherit (import ../../shared/caddy-helpers.nix) tlsDNSChallenge;
in
{
  imports = [
    ./apps
    ./btrfs.nix
    ./ssh.nix
    ../../shared/caddy.nix
    ../../shared/frp.nix
  ];

  services.caddy = {
    virtualHosts = {
      "gateway.labs.adtya.xyz" = {
        extraConfig = ''
          ${tlsDNSChallenge}
          reverse_proxy 192.168.0.1:80
        '';
      };
      "ap1.labs.adtya.xyz" = {
        extraConfig = ''
          ${tlsDNSChallenge}
          reverse_proxy 192.168.1.1:80
        '';
      };
      "ap2.labs.adtya.xyz" = {
        extraConfig = ''
          ${tlsDNSChallenge}
          reverse_proxy 192.168.1.2:80
        '';
      };
      "switch.labs.adtya.xyz" = {
        extraConfig = ''
          ${tlsDNSChallenge}
          reverse_proxy 192.168.1.3:80
        '';
      };
      "frp.labs.adtya.xyz" = {
        extraConfig = ''
          ${tlsDNSChallenge}
          reverse_proxy 10.10.10.1:7500
        '';
      };
    };
  };
}
