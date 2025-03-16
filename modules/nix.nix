{ lib, config, ... }:
let
  cfg = config.nodeconfig;
in
{
  options.nodeconfig = {
    nix.auto-gc = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enable Automatic Garbage collection of the Nix store";
    };
    nix.auto-optimise = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enable Automatic optimisation of the Nix store";
    };
    nix.is-laptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure the nix daemon for laptops";
    };
  };

  config =
    lib.mkIf cfg.nix.auto-gc {
      nix.gc = {
        automatic = true;
        dates = "Fri *-*-* 00:00:00";
        options = "--delete-old";
        randomizedDelaySec = "1h";
      };
    }
    // lib.mkIf cfg.nix.auto-optimise {
      nix.optimise = {
        automatic = true;
        dates = [ "Fri *-*-* 06:00:00" ];
      };
    }
    // lib.mkIf cfg.nix.is-laptop {
      nix.daemonCPUSchedPolicy = "idle";
      nix.daemonIOSchedClass = "idle";
    };
}
