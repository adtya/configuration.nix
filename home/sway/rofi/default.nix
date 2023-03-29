{ pkgs, ... }: {
  xdg.desktopEntries."rofi".name = "Rofi";
  xdg.desktopEntries."rofi".exec = "rofi -show";
  xdg.desktopEntries."rofi".noDisplay = true;

  xdg.desktopEntries."rofi-theme-selector".name = "Rofi Theme Selector";
  xdg.desktopEntries."rofi-theme-selector".exec = "rofi-theme-selector";
  xdg.desktopEntries."rofi-theme-selector".noDisplay = true;

  programs.rofi = {
    enable = true;
    cycle = false;
    package = pkgs.rofi-wayland;
    font = "FiraCode Nerd Font 16";
    extraConfig = {
      show-icons = true;
    };
    theme = ./theme.rasi;
  };
}
