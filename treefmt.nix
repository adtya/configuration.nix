{ pkgs, ... }:
{
  projectRootFile = "flake.nix";
  programs = {
    shellcheck.enable = true;
    shfmt.enable = true;
    deadnix = {
      enable = true;
      no-lambda-pattern-names = true;
    };
    statix.enable = true;
    nixfmt = {
      enable = true;
      strict = true;
    };
    yamlfmt.enable = true;
    prettier.enable = true;
  };
  settings.global = {
    excludes = [
      ".envrc"
      "LICENSE"
      "README.md"
      "*.png"
      "*/go.mod"
      "*/go.sum"
    ];
  };
}
