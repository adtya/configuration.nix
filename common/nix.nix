{ nixpkgs
, pkgs
, ...
}: {
  nix = {
    package = pkgs.nixFlakes;
    nixPath = [ "nixpkgs=${nixpkgs}" ];
    registry.nixpkgs.flake = nixpkgs;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "auto-allocate-uids" "cgroups" "ca-derivations" ];
      auto-allocate-uids = true;
      sandbox = true;
      trusted-substituters = [
        "https://varnam-nix.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "varnam-nix.cachix.org-1:IduaZzaMOJmY32L11e+a4fDDq6Xnq9/NcocAPcIbX9Y="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [ "@wheel" ];
      use-cgroups = true;
    };
  };
}
