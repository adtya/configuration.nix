{ pkgs, deploy-rs }:
{
  default = pkgs.mkShell {
    buildInputs = with pkgs; [
      age
      deploy-rs.packages.${pkgs.system}.default
      git
      just
      sops
      ssh-to-age
      nil
    ];
  };
}
