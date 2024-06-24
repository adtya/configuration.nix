_: {
  imports = [ ./filesystem.nix ./kernel.nix ];

  hardware = {
    raspberry-pi."4" = {
      poe-plus-hat.enable = true;
    };
  };
}
