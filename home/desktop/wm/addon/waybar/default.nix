{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 28;
        modules-left = [ "sway/workspaces" "wlr/workspaces" "sway/window" "hyprland/window" "sway/mode" "hyprland/submap" ];
        modules-center = [ ];
        modules-right = [ "tray" "idle_inhibitor" "network" "bluetooth" "pulseaudio" "backlight" "battery" "clock" ];
        "sway/mode" = {
          "format" = "{}";
        };
        "sway/window" = {
          "tooltip" = false;
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
          "tooltip" = false;
        };
        "clock" = {
          "tooltip" = false;
          "interval" = 1;
          "format" = "{:%I:%M}";
          "format-alt" = "{:%d %B %Y, %A}";
        };
        "backlight" = {
          "format" = "{icon}";
          "format-icons" = [ "" "" "" "" ];
        };
        "battery" = {
          "states" = {
            "good" = 90;
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon}";
          "format-alt" = "{icon} {capacity}% ({time})";
          "format-charging" = " {capacity}%";
          "format-plugged" = "‭ﮣ {capacity}%";
          "format-icons" = [ "" "" "" "" "" "" "" "" "" "" "" ];
          "tooltip" = false;
        };
        "network" = {
          "format-wifi" = "直";
          "format-ethernet" = "";
          "format-linked" = "";
          "format-disconnected" = "睊";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
          "tooltip" = false;
        };
        "pulseaudio" = {
          "tooltip" = false;
          "format" = "{icon} {format_source}";
          "format-muted" = "‭ﱝ {format_source}";
          "format-bluetooth" = " {icon} {format_source}";
          "format-bluetooth-muted" = " ‭ﱝ {format_source}";
          "format-source" = "";
          "format-source-muted" = "";
          "format-icons" = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "奄" "奔" "墳" ];
          };
          "on-click" = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        "bluetooth" = {
          "format" = "";
          "format-connected" = "";
          "format-disabled" = "";
          "format-off" = "";
          "format-connected-battery" = " {device_battery_percentage}%";
          "on-click" = "${pkgs.blueman}/bin/blueman-manager";
        };
        "tray" = {
          "spacing" = 4;
        };
      };
    };
  };
}