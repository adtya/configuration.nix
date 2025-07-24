_: {
  programs.waybar.settings = {
    mainBar = {
      modules-right = [
        "backlight"
        "battery"
      ];
      backlight = {
        format = "{icon}";
        format-icons = [
          "󰃚"
          "󰃛"
          "󰃜"
          "󰃝"
          "󰃞"
          "󰃟"
          "󰃠"
        ];
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
        format-icons = [
          "󰂃"
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
        tooltip = false;
      };
    };
  };
}
