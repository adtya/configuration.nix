{ nixpkgs
, pkgs
, ...
}: {
  environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
  nix = {
    package = pkgs.nixFlakes;
    nixPath = [ "nixpkgs=/etc/nix/inputs/nixpkgs" ];
    registry.nixpkgs.flake = nixpkgs;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "auto-allocate-uids" "cgroups" "ca-derivations" ];
      auto-allocate-uids = true;
      sandbox = true;
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://helix.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      trusted-users = [ "@wheel" ];
      use-cgroups = true;
    };
  };
}
