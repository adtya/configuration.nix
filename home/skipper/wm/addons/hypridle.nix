{ pkgs, ... }:
let
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
in
{
  services.hypridle.settings = {
    listener = [
      {
        timeout = 10;
        on-timeout = "${brightnessctl} --quiet --device=dell::kbd_backlight --save set 0";
        on-resume = "${brightnessctl} --quiet --device=dell::kbd_backlight --restore";
      }
      {
        timeout = 150;
        on-timeout = "${brightnessctl} --quiet --device=intel_backlight --save set 30";
        on-resume = "${brightnessctl} --quiet --device=intel_backlight --restore";
      }
    ];
  };
}
