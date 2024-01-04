{pkgs, flake_env, ...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    stdlib = ''
      source ${flake_env.packages.${pkgs.system}.flake_env}/share/flake_env/direnvrc
    '';
  };
}
