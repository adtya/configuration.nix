_: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
        hide_cursor = true;
      };
      background = {
        path = "screenshot";
        blur_passes = 2;
        blur_size = 5;
      };
      input-field = {
        outer_color = "rgb(bd93f9)";
        inner_color = "rgb(282a36)";
        font_color = "rgb(f8f8f2)";
        check_color = "rgb(f1fa8c)";
        fail_color = "rgb(ff5555)";
        size = "300, 48";
        outline_thickness = 1;
        position = "0, 48";
        rounding = 10;
        halign = "center";
        valign = "bottom";
        placeholder_text = ''<span font_family="Fira Code">password</span>'';
        fail_text = "🖕";
      };
      image = {
        path = "${./ghost.png}";
        size = 196;
        border_size = 0;
        shadow_passes = 2;
        shadow_color = "rgb(282a36)";
        position = "0, 120";
        halign = "center";
        valign = "bottom";
      };
    };
  };
}
