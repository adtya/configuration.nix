{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    cycle = false;
    package = pkgs.rofi;
    font = "Fira Code,Symbols Nerd Font 14";
    extraConfig = {
      show-icons = true;
    };
    theme = ./theme.rasi;
  };
  xdg.desktopEntries = {
    "rofi" = {
      name = "Rofi";
      exec = "rofi -show";
      noDisplay = true;
    };
    "rofi-theme-selector" = {
      name = "Rofi Theme Selector";
      exec = "rofi-theme-selector";
      noDisplay = true;
    };
  };
}
