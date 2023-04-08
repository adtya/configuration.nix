{ config, pkgs, ... }:
let
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  grim = "${pkgs.grim}/bin/grim";
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  kitty = "${config.programs.kitty.package}/bin/kitty";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  rofi = "${config.programs.rofi.package}/bin/rofi";
  slurp = "${pkgs.slurp}/bin/slurp";
  swaylock = "${pkgs.swaylock}/bin/swaylock";
  tmux = "${config.programs.tmux.package}/bin/tmux";
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

      general {
        col.active_border = rgb(bd93f9)
        col.inactive_border = rgba(44475aaa)
        col.group_border = rgba(282a36dd)
        col.group_border_active = rgb(bd93f9)

        border_size = 1
        gaps_in = 2
        gaps_out = 4

        layout = master
      }

      decoration {
        col.shadow = rgba(1E202966)
        drop_shadow = yes
        shadow_range = 60
        shadow_offset = 1 2
        shadow_render_power = 3
        shadow_scale = 0.97

        rounding = 5
        dim_around = 0.6
      }

      input {
        touchpad {
          clickfinger_behavior = true
          disable_while_typing = true
          natural_scroll = true
          tap-to-click = true
        }
      }

      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
      }

      master {
        new_is_master = true
        new_on_top = true
      }

      animation = windows,1,3,default,slide
      animation = fade,1,3,default
      animation = border,1,3,default
      animation = borderangle,1,3,default
      animation = workspaces,1,3,default,slide

      windowrulev2 = bordercolor rgb(ff5555),xwayland:1 

      windowrulev2 = workspace 2,class:^(firefox)$,title:^(Mozilla Firefox)$

      windowrulev2 = nofullscreenrequest,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$
      windowrulev2 = float,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$
      windowrulev2 = move 95% 50%,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$

      windowrulev2 = float,class:^(pavucontrol)$,title:^(Volume Control)$
      windowrulev2 = size 50% 50%,class:^(pavucontrol)$,title:^(Volume Control)$
      windowrulev2 = center,class:^(pavucontrol)$,title:^(Volume Control)$

      windowrulev2 = float,class:^(.blueman-manager-wrapped)$
      windowrulev2 = size 50% 50%,class:^(.blueman-manager-wrapped)$
      windowrulev2 = center,class:^(.blueman-manager-wrapped)$

      windowrulev2 = float,class:^(mpv)$
      windowrulev2 = size 90% 90%,class:^(mpv)$
      windowrulev2 = center,class:^(mpv)$
      windowrulev2 = dimaround,class:^(mpv)$

      windowrulev2 = float,class:^(io.github.celluloid_player.Celluloid)$
      windowrulev2 = size 90% 90%,class:^(io.github.celluloid_player.Celluloid)$
      windowrulev2 = center,class:^(io.github.celluloid_player.Celluloid)$
      windowrulev2 = dimaround,class:^(io.github.celluloid_player.Celluloid)$

      windowrulev2 = float,class:^(eog)$
      windowrulev2 = float,class:^(eog)$
      windowrulev2 = size 90% 90%,class:^(eog)$
      windowrulev2 = center,class:^(eog)$
      windowrulev2 = dimaround,class:^(eog)$

      windowrulev2 = float,class:^(org.gnome.Nautilus)$
      windowrulev2 = center,class:^(org.gnome.Nautilus)$
      windowrulev2 = size 60% 60%,class:^(org.gnome.Nautilus)$

      windowrulev2 = float,class:^(gnome-system-monitor)$
      windowrulev2 = center,class:^(gnome-system-monitor)$
      windowrulev2 = size 60% 50%,class:^(gnome-system-monitor)$

      windowrulev2 = float,class:^(virt-manager)$
      windowrulev2 = size 20% 50%,class:^(virt-manager)$,title:^(Virtual Machine Manager)$
      windowrulev2 = move 5%% 10%,class:^(virt-manager)$,title:^(Virtual Machine Manager)$

      windowrulev2 = float,class:^(.yubioath-flutter-wrapped)$
      windowrulev2 = center,class:^(.yubioath-flutter-wrapped)$

      windowrulev2 = float,class:^(yubico.org.)$
      windowrulev2 = center,class:^(yubico.org.)$

      exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
      exec-once = ${hyprctl} setcursor ${config.gtk.cursorTheme.name} 24
      exec-once = ${change-wallpaper}

      bindm = SUPER,mouse:272,           movewindow
      bindm = SUPER_SHIFT,mouse:272,     resizewindow

      bind = SUPER_SHIFT,Q,       killactive,
      bind = SUPER_SHIFT,space,   togglefloating,active
      bind = SUPER_SHIFT,F,       fullscreen,0

      bind = SUPER_SHIFT,C,       exec, ${hyprctl} reload
      bind = SUPER_SHIFT,C,       exec, systemctl --user restart swayidle.service
      bind = SUPER_SHIFT,C,       exec, systemctl --user restart kanshi.service
      bind = SUPER_SHIFT,C,       exec, systemctl --user reload waybar.service

      bind = SUPER,Return,        exec, ${kitty} ${tmux} new
      bind = SUPER_SHIFT,Return,  exec, ${kitty}
      bind = SUPER,d,             exec, ${rofi} -show drun
      bind = SUPER,escape,             exec, ${swaylock} -f -i /tmp/lockpaper.jpg
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

      bind = SUPER,l,             layoutmsg,cyclenext
      bind = SUPER,h,             layoutmsg,cycleprev
      bind = SUPER,m,             layoutmsg,focusmaster
      bind = SUPER_SHIFT,m,       layoutmsg,swapwithmaster

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
