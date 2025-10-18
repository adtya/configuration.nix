{ lib, pkgs, ... }:
let
  brightnessctl = lib.getExe pkgs.brightnessctl;
in
{
  wayland.windowManager.hyprland = {
    settings = {
      monitorv2 = [
        {
          output = "eDP-1";
          mode = "preferred";
          position = "0x0";
          scale = "1";
          transform = 0;
        }
        {
          output = "";
          mode = "preferred";
          position = "auto-right";
          scale = "auto";
          transform = 0;
        }
      ];

      input = {
        touchpad = {
          clickfinger_behavior = true;
          disable_while_typing = true;
          natural_scroll = true;
          tap-to-click = true;
        };
      };

      gestures = {
        workspace_swipe = "on";
      };

      binde = [
        ",XF86MonBrightnessUp,   exec, ${brightnessctl} --quiet --device=intel_backlight set +5%"
        ",XF86MonBrightnessDown, exec, ${brightnessctl} --quiet --device=intel_backlight set 5%-"
      ];
    };
  };
}
