{ lib, config, ... }:
let cfg = config.nodeconfig; in {
  options.nix.auto-gc = lib.mkOption {
    type = lib.types.bool;
    default = false;
    example = true;
    description = "Enable Automatic Garbage collection of the Nix store";
  };

  config = lib.mkIf cfg.nix.auto-gc {
    nix.gc = {
      automatic = true;
      dates = "Fri *-*-* 00:00:00";
      options = "--delete-old";
      randomizedDelaySec = "1h";
    };
  };
}
