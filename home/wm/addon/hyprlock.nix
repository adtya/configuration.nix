_: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
      };
      background = {
        path = "screenshot";
        blur_passes = 2;
        blur_size = 5;
      };
    };
  };
}
