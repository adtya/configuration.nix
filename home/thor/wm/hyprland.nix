{ lib, pkgs, ... }:
let
  pkill = lib.getExe' pkgs.procps "pkill";
in
{
  wayland.windowManager.hyprland = {
    settings = {
      render.cm_auto_hdr = 2;
      misc.vrr = 2;

      monitorv2 = [
        {
          output = "DP-1";
          mode = "3440x1440@175";
          position = "0x0";
          scale = "auto";
          transform = 0;
          vrr = 2;
          supports_wide_color = 1;
          supports_hdr = 1;
          bitdepth = 10;
        }
      ];

      bind = [ "SUPER_ALT, W, exec, ${pkill} -SIGUSR1 waybar" ];

      windowrule = [
        "match:class mpv, no_vrr on"

        "match:class .virt-manager-wrapped,                                      float 1"
        "match:class .virt-manager-wrapped, match:title Virtual Machine Manager, size (monitor_w*0.25) (monitor_h*0.5), move (monitor_w*0.05) (monitor_h*0.1)"
        "match:class .piper-wrapped,                                             float 1, size (monitor_w*0.5) (monitor_h*0.5), center 1"
        "match:class steam,                                                      workspace 9, float 1"
        "match:class net.lutris.Lutris,                                          workspace 9, float 1, center 1, size (monitor_w*0.6) (monitor_h*0.6)"

      ];
    };
  };
}
