{ pkgs, deploy-rs }:
{
  default = pkgs.mkShell {
    buildInputs = with pkgs; [
      git
      sops
      age
      ssh-to-age
      deploy-rs.packages.${pkgs.system}.default
    ];
  };
}
