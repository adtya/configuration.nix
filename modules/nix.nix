{ lib, config, ... }:
let
  cfg = config.nodeconfig.nix;
in
{
  options.nodeconfig.nix = {
    auto-gc = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enable Automatic Garbage collection of the Nix store";
    };
    auto-optimise = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enable Automatic optimisation of the Nix store";
    };
    is-laptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Configure the nix daemon for laptops";
    };
    disable-channels = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Disable channels support";
    };
    cool-features = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Enable cool (but experimental) features";
    };
    trust-wheel = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Add @wheel to trusted users";
    };
    enable-extra-substituters = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
      description = "Enable additional substituters";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.auto-gc {
      nix.gc = {
        automatic = true;
        dates = "Fri *-*-* 00:00:00";
        options = "--delete-old";
        randomizedDelaySec = "1h";
      };
    })
    (lib.mkIf cfg.auto-optimise {
      nix.optimise = {
        automatic = true;
        dates = [ "Fri *-*-* 06:00:00" ];
      };
    })
    (lib.mkIf cfg.is-laptop {
      nix.daemonCPUSchedPolicy = "idle";
      nix.daemonIOSchedClass = "idle";
    })
    (lib.mkIf cfg.disable-channels { nix.channel.enable = false; })
    (lib.mkIf cfg.cool-features {
      nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "auto-allocate-uids"
          "cgroups"
          "ca-derivations"
        ];
        auto-allocate-uids = true;
        sandbox = true;
        use-cgroups = true;
      };
    })
    (lib.mkIf cfg.trust-wheel { nix.settings.trusted-users = [ "@wheel" ]; })
    (lib.mkIf cfg.enable-extra-substituters {
      nix.settings = {
        substituters = [
          "https://adtya.cachix.org"
          "https://cache.soopy.moe"
          "https://nix-community.cachix.org"
          "https://cache.nixos.org"
        ];
        trusted-substituters = [
          "https://adtya.cachix.org"
          "https://cache.soopy.moe"
          "https://nix-community.cachix.org"
          "https://cache.nixos.org"
        ];
        trusted-public-keys = [
          "adtya.cachix.org-1:lAuNLx0Ehzx6FoH20rVkMD7KyZZevlLfvm3lwMAzrnU="
          "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      };
    })
  ];
}
