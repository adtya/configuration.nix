{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override {
      hyprlandSupport = true;
      swaySupport = false;
    };
    systemd.enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 28;
        modules-left = [ "hyprland/workspaces" "hyprland/window" "hyprland/submap" ];
        modules-center = [ ];
        modules-right = [ "tray" "idle_inhibitor" "network" "bluetooth" "wireplumber" "backlight" "battery" "clock" ];
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰈈";
            deactivated = "󰈉";
          };
          tooltip = false;
        };
        clock = {
          tooltip = false;
          interval = 1;
          format = "{:%H:%M}";
          format-alt = "{:%d %B %Y, %A}";
        };
        backlight = {
          format = "{icon}";
          format-icons = [ "󰃚" "󰃛" "󰃜" "󰃝" "󰃞" "󰃟" "󰃠" ];
          tooltip = false;
        };
        battery = {
          states = {
            good = 90;
            warning = 30;
            critical = 10;
          };
          format = "{icon}";
          format-alt = "{icon} {capacity}% ({time})";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "‭󰚥 {capacity}%";
          format-icons = [ "󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip = false;
        };
        network = {
          format-wifi = "󰖩";
          format-ethernet = "󰈀";
          format-linked = "󰌷";
          format-disconnected = "󰖪";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          tooltip = false;
        };
        wireplumber = {
          format = "{icon}";
          format-muted = "‭󰝟";
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          format-icons = [ "󰕿" "󰖀" "󰕾" ];
          tooltip = false;
        };
        bluetooth = {
          format = "󰂯";
          format-connected = "󰂱";
          format-disabled = "󰂲";
          format-off = "󰂲";
          on-click = "${pkgs.blueberry}/bin/blueberry";
          tooltip = false;
        };
        tray = {
          spacing = 4;
        };
      };
    };
  };
}
