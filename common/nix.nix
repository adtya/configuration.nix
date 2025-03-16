_: {
  nix = {
    channel.enable = false;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "auto-allocate-uids"
        "cgroups"
        "ca-derivations"
      ];
      auto-allocate-uids = true;
      sandbox = true;
      trusted-substituters = [
        "https://adtya.cachix.org"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "adtya.cachix.org-1:lAuNLx0Ehzx6FoH20rVkMD7KyZZevlLfvm3lwMAzrnU="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [ "@wheel" ];
      use-cgroups = true;
    };
  };
}
