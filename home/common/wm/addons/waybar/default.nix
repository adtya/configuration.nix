{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    systemd.enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 28;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
          "hyprland/submap"
        ];
        modules-center = [ ];
        modules-right = [
          "tray"
          "idle_inhibitor"
          "network"
          "bluetooth"
          "wireplumber"
          "clock"
          "custom/notification"
        ];
        "hyprland/workspaces" = {
          separate-outputs = true;
        };
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
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
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
        "custom/notification" =
          let
            swaync-client = "${pkgs.swaynotificationcenter}/bin/swaync-client";
          in
          {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "󱅫";
              none = "󰂚";
              dnd-notification = "󰂠";
              dnd-none = "󰂠";
              inhibited-notification = "󰂛";
              inhibited-none = "󰂛";
              dnd-inhibited-notification = "󰂛";
              dnd-inhibited-none = "󰂛";
            };
            return-type = "json";
            exec = "${swaync-client} -swb";
            on-click = "${swaync-client} -d -sw";
          };
      };
    };
  };
}
