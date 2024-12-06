{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font";
      size = 14;
    };
    settings = {
      enable_audio_bell = false;
      initial_window_width = "100c";
      initial_window_height = "25c";
      window_padding_width = "4.0";
      background_opacity = "0.98";
      cursor_shape = "beam";
      scrollback_lines = 2000;
      copy_on_select = "clipboard";
      url_style = "curly";
      sync_to_monitor = true;
    };
    shellIntegration.mode = "disabled";
    themeFile = "Dracula";
  };
}
