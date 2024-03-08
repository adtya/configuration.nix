{ config
, pkgs
, ...
}:
let
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  firefox = "${config.programs.firefox.finalPackage}/bin/firefox";
  grimblast = "${pkgs.grimblast}/bin/grimblast";
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  kitty = "${config.programs.kitty.package}/bin/kitty";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  rofi = "${config.programs.rofi.package}/bin/rofi";
  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
  tmux = "${config.programs.tmux.package}/bin/tmux";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";

  pictures = "${config.xdg.userDirs.pictures}";
  change-wallpaper = "${pkgs.scripts}/bin/chpaper ${pictures}/Wallpapers";
  wallhaven-wallpaper = "${pkgs.scripts}/bin/chpaper \$(${pkgs.scripts}/bin/wallhaven ${pictures}/Wallpapers)";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    settings = {
      general = {
        border_size = 1;
        "col.active_border" = "rgb(bd93f9)";
        "col.inactive_border" = "rgba(44475aaa)";
        "col.nogroup_border" = "rgba(282a36dd)";
        "col.nogroup_border_active" = "rgb(bd93f9)";
        gaps_in = 2;
        gaps_out = 4;
        layout = "master";
      };

      decoration = {
        "col.shadow" = "rgba(1E202966)";
        dim_around = 0.6;
        drop_shadow = "yes";
        rounding = 5;
        shadow_range = 60;
        shadow_offset = "1 2";
        shadow_render_power = 3;
        shadow_scale = 0.97;
      };

      monitor = [
        "eDP-1,  1920x1080,  0x0,   1"
        ",       preferred,  auto,  1"
        # ",       preferred,  auto,  1,  mirror,  eDP-1"
      ];

      input = {
        kb_layout = "us";
        kb_options = "rupeesign:4";
        kb_variant = "altgr-intl";
        touchpad = {
          clickfinger_behavior = true;
          disable_while_typing = true;
          natural_scroll = true;
          tap-to-click = true;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
      };

      master = {
        new_is_master = true;
        new_on_top = true;
        mfact = 0.65;
      };

      animation = [
        "windows,1,3,default,slide"
        "fade,1,3,default"
        "border,1,3,default"
        "borderangle,1,3,default"
        "workspaces,1,3,default,slide"
      ];

      windowrulev2 = [
        "bordercolor rgb(ff5555),xwayland:1"

        "workspace 2,class:^(firefox)$,title:^(Mozilla Firefox)$"

        "float,class:^(firefox)$,title:^(Library)$"

        "float,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$"
        "move 95% 50%,class:^(firefox)$,title:^(Firefox — Sharing Indicator)$"

        "float,class:^(pavucontrol)$,title:^(Volume Control)$"
        "size 50% 50%,class:^(pavucontrol)$,title:^(Volume Control)$"
        "center,class:^(pavucontrol)$,title:^(Volume Control)$"

        "float,class:^(.blueman-manager-wrapped)$"
        "size 50% 50%,class:^(.blueman-manager-wrapped)$"
        "center,class:^(.blueman-manager-wrapped)$"

        "float,class:^(ytfzf)$"
        "size 90% 90%,class:^(ytfzf)$"
        "center,class:^(ytfzf)$"

        "float,class:^(mpv)$"
        "size 90% 90%,class:^(mpv)$"
        "center,class:^(mpv)$"
        "dimaround,class:^(mpv)$"

        "float,class:^(org.gnome.Loupe)$"
        "size 90% 90%,class:^(org.gnome.Loupe)$"
        "center,class:^(org.gnome.Loupe)$"
        "dimaround,class:^(org.gnome.Loupe)$"

        "float,class:^(org.gnome.Nautilus)$"
        "center,class:^(org.gnome.Nautilus)$"
        "size 60% 60%,class:^(org.gnome.Nautilus)$"

        "float,class:^(.yubioath-flutter-wrapped_)$"
        "center,class:^(.yubioath-flutter-wrapped_)$"

        "float,class:lutris"
        "center,class:lutris"
        "size 60% 60%,class:lutris"

        "dimaround,class:^(gcr-prompter)$"
      ];

      exec-once = [
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "${hyprctl} setcursor ${config.gtk.cursorTheme.name} 24"
        "${change-wallpaper}"
      ];

      bindm = [
        "SUPER,mouse:272,           movewindow"
        "SUPER_SHIFT,mouse:272,     resizewindow"
      ];

      bind = [
        "SUPER_SHIFT,Q,       killactive,"
        "SUPER_SHIFT,space,   togglefloating,active"
        "SUPER_SHIFT,space,   centerwindow"
        "SUPER_SHIFT,F,       fullscreen,0"
        "SUPER_ALT,F,         fakefullscreen"

        "SUPER_SHIFT,C,       exec, ${hyprctl} reload"
        "SUPER_SHIFT,C,       exec, systemctl --user restart swayidle.service"
        "SUPER_SHIFT,C,       exec, systemctl --user restart kanshi.service"
        "SUPER_SHIFT,C,       exec, systemctl --user reload waybar.service"

        "SUPER,Return,        exec, ${kitty} ${tmux} new"
        "SUPER_SHIFT,Return,  exec, ${kitty}"
        "SUPER,d,             exec, ${rofi} -show drun"
        "SUPER,i,             exec, ${firefox}"
        "SUPER_SHIFT,i,       exec, ${firefox} --private-window"

        "SUPER_SHIFT,escape,  exec, ${pkgs.scripts}/bin/power-menu"
        "SUPER,f11,           exec, ${pkgs.scripts}/bin/tmux-sessions"
        "SUPER_SHIFT,y,       exec, ${pkgs.scripts}/bin/youtube"
        "SUPER_SHIFT,b,       exec, ${pkgs.rofi-bluetooth}/bin/rofi-bluetooth"

        "SUPER,escape,        exec, ${swaylock} -f -i /tmp/wallpaper.jpg"
        "SUPER_SHIFT,W,       exec, ${change-wallpaper}"
        "SUPER_ALT,W,         exec, ${wallhaven-wallpaper}"

        "SUPER,1,             workspace, 1"
        "SUPER,2,             workspace, 2"
        "SUPER,3,             workspace, 3"
        "SUPER,4,             workspace, 4"
        "SUPER,5,             workspace, 5"
        "SUPER,6,             workspace, 6"
        "SUPER,7,             workspace, 7"
        "SUPER,8,             workspace, 8"
        "SUPER,9,             workspace, 9"
        "SUPER,0,             workspace, 10"

        "SUPER_SHIFT,1,       movetoworkspace, 1"
        "SUPER_SHIFT,2,       movetoworkspace, 2"
        "SUPER_SHIFT,3,       movetoworkspace, 3"
        "SUPER_SHIFT,4,       movetoworkspace, 4"
        "SUPER_SHIFT,5,       movetoworkspace, 5"
        "SUPER_SHIFT,6,       movetoworkspace, 6"
        "SUPER_SHIFT,7,       movetoworkspace, 7"
        "SUPER_SHIFT,8,       movetoworkspace, 8"
        "SUPER_SHIFT,9,       movetoworkspace, 9"
        "SUPER_SHIFT,0,       movetoworkspace, 10"

        "SUPER,l,             layoutmsg,cyclenext"
        "SUPER,h,             layoutmsg,cycleprev"
        "SUPER,m,             layoutmsg,focusmaster"
        "SUPER_SHIFT,m,       layoutmsg,swapwithmaster"

        ",XF86AudioMute,      exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay,      exec, ${playerctl} play-pause"
        ",XF86AudioNext,      exec, ${playerctl} next"
        ",XF86AudioPrev,      exec, ${playerctl} previous"
      ];

      bindr = [
        ",print,             exec, XDG_SCREENSHOTS_DIR=${pictures}/Screenshots ${grimblast} --notify save screen"
        "SHIFT,print,        exec, XDG_SCREENSHOTS_DIR=${pictures}/Screenshots ${grimblast} --notify --freeze save area"
      ];

      binde = [
        ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
        ",XF86MonBrightnessDown, exec, ${brightnessctl} set 5%-"
        ",XF86AudioRaiseVolume,  exec, ${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,  exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
    };
  };
}
