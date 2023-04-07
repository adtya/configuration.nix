{ config, pkgs, ... }:
let
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  grim = "${pkgs.grim}/bin/grim";
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  kitty = "${pkgs.kitty}/bin/kitty";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  rofi = "${pkgs.rofi-wayland}/bin/rofi";
  slurp = "${pkgs.slurp}/bin/slurp";
  swaylock = "${pkgs.swaylock}/bin/swaylock";
  tmux = "${pkgs.tmux}/bin/tmux";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  xdg-user-dir = "${pkgs.xdg-user-dirs}/bin/xdg-user-dir";
  change-wallpaper = "${pkgs.scripts}/bin/chpaper ${pkgs.catppuccin-wallpapers}/share/wallpapers";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    recommendedEnvironment = true;
    extraConfig = ''
      monitor = eDP-1,  1920x1080,  0x0,   1
      monitor = ,       preferred,  auto,  1

      input {
        touchpad {
          disable_while_typing = true
          middle_button_emulation = true
          natural_scroll = true
          tap-to-click = true
        }
      }

      exec-once = ${hyprctl} setcursor ${config.gtk.cursorTheme.name} 24
      exec-once = ${change-wallpaper}

      bindm = SUPER,mouse:272,           movewindow
      bindm = SUPER_SHIFT,mouse:272,     resizewindow

      bind = SUPER_SHIFT,Q,       killactive,
      bind = SUPER_SHIFT,space,   togglefloating,active
      bind = SUPER_SHIFT,F,       fullscreen,0

      bind = SUPER_SHIFT,C,       exec, ${hyprctl} reload
      bind = SUPER_SHIFT,C,       exec, systemctl --user restart waybar.service
      bind = SUPER,Return,        exec, ${kitty} ${tmux} new
      bind = SUPER_SHIFT,Return,  exec, ${kitty}
      bind = SUPER,d,             exec, ${rofi} -show drun
      bind = SUPER,l,             exec, ${swaylock} -f -i /tmp/lockpaper.jpg
      bind = SUPER_SHIFT,W,       exec, ${change-wallpaper}
      bind = SUPER_SHIFT,escape,  exec, ${pkgs.scripts}/bin/power-menu
      bind = SUPER,f11,           exec, ${pkgs.scripts}/bin/tmux-sessions

      bindr = ,print,              exec, ${grim} "''$(${xdg-user-dir} PICTURES)/Screenshots/screenshot-''$(date +%Y-%m-%d-%H-%M-%S).png"
      bindr = SHIFT,print,         exec, ${grim} -g "''$(${slurp})" "''$(${xdg-user-dir} PICTURES)/Screenshots/screenshot-''$(date +%Y-%m-%d-%H-%M-%S).png"

      bind = SUPER,1,             workspace, 1
      bind = SUPER,2,             workspace, 2
      bind = SUPER,3,             workspace, 3
      bind = SUPER,4,             workspace, 4
      bind = SUPER,5,             workspace, 5
      bind = SUPER,6,             workspace, 6
      bind = SUPER,7,             workspace, 7
      bind = SUPER,8,             workspace, 8
      bind = SUPER,9,             workspace, 9

      bind = SUPER_SHIFT,1,       movetoworkspace, 1
      bind = SUPER_SHIFT,2,       movetoworkspace, 2
      bind = SUPER_SHIFT,3,       movetoworkspace, 3
      bind = SUPER_SHIFT,4,       movetoworkspace, 4
      bind = SUPER_SHIFT,5,       movetoworkspace, 5
      bind = SUPER_SHIFT,6,       movetoworkspace, 6
      bind = SUPER_SHIFT,7,       movetoworkspace, 7
      bind = SUPER_SHIFT,8,       movetoworkspace, 8
      bind = SUPER_SHIFT,9,       movetoworkspace, 9

      binde = ,XF86MonBrightnessUp,   exec, ${brightnessctl} set +2%
      binde = ,XF86MonBrightnessDown, exec, ${brightnessctl} set 2%-
      bind  = ,XF86AudioMute,         exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle
      binde = ,XF86AudioRaiseVolume,  exec, ${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+
      binde = ,XF86AudioLowerVolume,  exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 2%-
      bind  = ,XF86AudioPlay,         exec, ${playerctl} play-pause
      bind  = ,XF86AudioNext,         exec, ${playerctl} next
      bind  = ,XF86AudioPrev,         exec, ${playerctl} previous
    '';
  };
}
