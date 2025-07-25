{ lib, pkgs, ... }:
let
  brightnessctl = lib.getExe pkgs.brightnessctl;
in
{
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "eDP-1,  preferred,  0x0,         1"
        ",       preferred,  auto-right,  auto"
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
