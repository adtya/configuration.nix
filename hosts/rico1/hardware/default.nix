_: {
  imports = [ ./filesystem.nix ./kernel.nix ];

  hardware = {
    deviceTree = {
      enable = true;
    };
    raspberry-pi."4" = {
      apply-overlays-dtmerge.enable = true;
      poe-plus-hat.enable = true;
      xhci.enable = true;
    };
  };
}
