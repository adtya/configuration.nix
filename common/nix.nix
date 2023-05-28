{nixpkgs, ...}: {
  environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
  nix = {
    nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
    registry.nixpkgs.flake = nixpkgs;
    settings = {
      trusted-substituters = [
        "https://nix-community.cachix.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes" "auto-allocate-uids" "cgroups" "ca-derivations"];
      auto-allocate-uids = true;
      use-cgroups = true;
    };
  };
  nixpkgs.config.allowUnfree = true;
}
