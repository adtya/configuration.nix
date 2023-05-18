{...}: {
  nix.settings = {
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
  nixpkgs.config.allowUnfree = true;
}
