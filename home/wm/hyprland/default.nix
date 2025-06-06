{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.wayland.windowManager.hyprland;

  brightnessctl = lib.getExe pkgs.brightnessctl;
  blueberry = "${pkgs.blueberry}/bin/blueberry";
  firefox = lib.getExe config.programs.firefox.finalPackage;
  grimblast = lib.getExe pkgs.grimblast;
  hyprctl = "${cfg.package}/bin/hyprctl";
  kitty = lib.getExe config.programs.kitty.package;
  librewolf = lib.getExe pkgs.librewolf;
  loginctl = "${pkgs.systemd}/bin/loginctl";
  playerctl = lib.getExe pkgs.playerctl;
  rofi = lib.getExe config.programs.rofi.package;
  swaync-client = "${pkgs.swaynotificationcenter}/bin/swaync-client";
  tmux = lib.getExe config.programs.tmux.package;
  uwsm = lib.getExe pkgs.uwsm;
  walker = lib.getExe pkgs.walker;
  wpaperctl = "${config.services.wpaperd.package}/bin/wpaperctl";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  yazi = lib.getExe pkgs.yazi;

  pictures = "${config.xdg.userDirs.pictures}";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      ecosystem.no_update_news = true;
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

      master = {
        mfact = 0.65;
        new_status = "master";
        new_on_top = true;
        drop_at_cursor = false;
      };

      decoration = {
        dim_around = 0.6;
        rounding = 5;
        blur = {
          enabled = true;
          size = 5;
          passes = 1;
        };
        shadow = {
          color = "rgba(1E202966)";
          range = 3;
          render_power = 3;
          scale = 0.97;
        };
      };

      monitor = [
        "eDP-1,  preferred,  0x0,         1"
        ",       preferred,  auto-right,  auto"
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

      gestures = {
        workspace_swipe = "on";
      };

      animations = {
        enabled = true;
        animation = [
          "windows,1,3,default,slide"
          "windowsOut,1,3,default,slide"
          "fade,1,3,default"
          "border,1,3,default"
          "borderangle,1,3,default"
          "workspaces,1,3,default,slide"
        ];
      };

      windowrulev2 = [
        "bordercolor rgb(ff5555),xwayland:1"

        "workspace 2,class:firefox,title:Mozilla Firefox"
        "workspace 10,class:im.dino.Dino"
        "workspace 10,class:org.telegram.desktop"
        "workspace 10,class:discord"

        "float,class:org.pulseaudio.pavucontrol"
        "size 50% 50%,class:org.pulseaudio.pavucontrol"
        "center,class:org.pulseaudio.pavucontrol"

        "float,class:blueberry.py"
        "size 50% 50%,class:blueberry.py"
        "center,class:blueberry.py"

        "float,class:.blueman-manager-wrapped"
        "size 50% 50%,class:.blueman-manager-wrapped"
        "center,class:.blueman-manager-wrapped"

        "float,class:mpv"
        "size 90% 90%,class:mpv"
        "center,class:mpv"
        "dimaround,class:mpv"

        "float,class:^(swayimg_.*)$"
        "size 90% 90%,class:^(swayimg_.*)$"
        "center,class:^(swayimg_.*)$"

        "float,class:org.pwmt.zathura"
        "size 90% 90%,class:org.pwmt.zathura"
        "center,class:org.pwmt.zathura"

        "float,class:org.gnome.Software"
        "center,class:org.gnome.Software"
        "size 60% 60%,class:org.gnome.Software"

        "float,class:org.gnome.Software"
        "center,class:org.gnome.Software"
        "size 60% 60%,class:org.gnome.Software"

        "dimaround,class:^(gcr-prompter)$"
      ];

      layerrule = [
        "blur, waybar"
        "ignorezero, waybar"
      ];

      exec-once = [ "${hyprctl} setcursor ${config.gtk.cursorTheme.name} 24" ];

      bindm = [
        "SUPER,mouse:272,           movewindow"
        "SUPER_SHIFT,mouse:272,     resizewindow"
      ];

      bind = [
        "SUPER_SHIFT,Q,       killactive,"
        "SUPER_SHIFT,space,   togglefloating,active"
        "SUPER_SHIFT,space,   centerwindow"
        "SUPER_SHIFT,F,       fullscreen,0"

        "SUPER_SHIFT,C,       exec, ${hyprctl} reload"
        "SUPER_SHIFT,C,       exec, systemctl --user restart kanshi.service"

        "SUPER,Return,        exec, ${uwsm} app -- ${kitty} ${tmux} -u new"
        "SUPER_SHIFT,Return,  exec, ${uwsm} app -- ${kitty}"
        ''SUPER,d,            exec, ${rofi} -show drun -run-command "${uwsm} app -- {cmd}"''
        "SUPER_SHIFT,d,       exec, ${walker}"
        "SUPER,e,             exec, ${uwsm} app -- ${kitty} --class=yazi ${yazi}"
        "SUPER_SHIFT,u,       exec, ${swaync-client} -t -sw"
        "SUPER,i,             exec, ${uwsm} app -- ${firefox}"
        "SUPER_SHIFT,i,       exec, ${uwsm} app -- ${librewolf}"

        "SUPER_SHIFT,escape,  exec, ${pkgs.misc-scripts}/bin/power-menu"
        "SUPER,f11,           exec, ${pkgs.misc-scripts}/bin/tmux-sessions"
        "SUPER_SHIFT,b,       exec, ${uwsm} app -- ${blueberry}"

        "SUPER,escape,        exec, ${loginctl} lock-session"
        "SUPER_SHIFT,W,       exec, ${wpaperctl} next"

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

        "SUPER,l,             layoutmsg,rollnext"
        "SUPER,h,             layoutmsg,rollprev"
        "SUPER_SHIFT,z,       layoutmsg,orientationcycle left right"
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
        ",XF86MonBrightnessUp,   exec, ${brightnessctl} --quiet --device=intel_backlight set +5%"
        ",XF86MonBrightnessDown, exec, ${brightnessctl} --quiet --device=intel_backlight set 5%-"
        ",XF86AudioRaiseVolume,  exec, ${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,  exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
    };
  };
}
