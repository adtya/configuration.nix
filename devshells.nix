{ pkgs, deploy-rs }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  default = pkgs.mkShell {
    buildInputs = with pkgs; [
      age
      deploy-rs.packages.${system}.default
      git
      just
      sops
      ssh-to-age
      nil
      dnscontrol
    ];
  };
}
