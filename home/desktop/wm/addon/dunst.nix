{
  config,
  pkgs,
  ...
}: let
  dmenu = "${config.programs.rofi.package}/bin/rofi -dmenu";
  firefox = "${config.programs.firefox.package}/bin/firefox";
in {
  services.dunst = {
    enable = true;
    iconTheme.name = config.gtk.iconTheme.name;
    iconTheme.package = config.gtk.iconTheme.package;
    settings = {
      global = {
        font = "FiraCode Nerd Font 11";
        monitor = 0;
        width = 300;
        height = 300;
        origin = "top-right";
        offset = "10x50";
        scale = 0;
        notification_limit = 0;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        indicate_hidden = "yes";
        transparency = 15;
        separator_height = 1;
        padding = 8;
        horizontal_padding = 10;
        text_icon_padding = 0;
        frame_width = 0;

        frame_color = "#282a36";
        separator_color = "frame";
        sort = "yes";
        idle_threshold = 120;
        line_height = 0;
        markup = "full";
        format = ''%s %p\n%b'';
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        icon_position = "left";
        min_icon_size = 0;
        max_icon_size = 64;
        sticky_history = "yes";
        history_length = 20;
        dmenu = "${dmenu} -p dunst";
        browser = "${firefox} -new-tab";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 0;
        ignore_dbusclose = false;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
      urgency_low = {
        background = "#282a36";
        foreground = "#6272a4";
        timeout = 10;
      };
      urgency_normal = {
        background = "#282a36";
        foreground = "#bd93f9";
        timeout = 10;
      };
      urgency_critical = {
        background = "#ff5555";
        foreground = "#f8f8f2";
        frame_color = "#ff5555";
        timeout = 0;
      };
    };
  };
}
