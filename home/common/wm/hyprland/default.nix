{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.wayland.windowManager.hyprland;

  overskride = lib.getExe pkgs.overskride;
  firefox = lib.getExe config.programs.firefox.finalPackage;
  grimblast = lib.getExe pkgs.grimblast;
  hyprctl = "${cfg.package}/bin/hyprctl";
  ghostty = lib.getExe config.programs.ghostty.package;
  librewolf = lib.getExe pkgs.librewolf;
  loginctl = "${pkgs.systemd}/bin/loginctl";
  playerctl = lib.getExe pkgs.playerctl;
  rofi = lib.getExe config.programs.rofi.package;
  uwsm = lib.getExe pkgs.uwsm;
  wpaperctl = "${config.services.wpaperd.package}/bin/wpaperctl";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  yazi = lib.getExe pkgs.yazi;
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
        mfact = 0.8;
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

      input = {
        kb_layout = "us";
        kb_options = "rupeesign:4";
        kb_variant = "altgr-intl";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
      };

      animations = {
        enabled = true;
        animation = [
          "windows,1,5,default,popin"
          "windowsOut,1,5,default,gnomed"
          "layers,1,5,default,slide"
          "fade,1,5,default"
          "border,1,5,default"
          "workspaces,1,5,default,slide"
          "workspacesOut,1,5,default,slide"
        ];
      };

      windowrulev2 = [
        "bordercolor rgb(ff5555),xwayland:1"

        "workspace 2,class:firefox,title:Mozilla Firefox"
        "float,class:firefox,title:Library"
        "size 50% 50%,class:firefox,title:Library"

        "float,class:com.saivert.pwvucontrol"
        "size 50% 50%,class:com.saivert.pwvucontrol"
        "center,class:com.saivert.pwvucontrol"

        "float,class:io.github.kaii_lb.Overskride"
        "size 50% 50%,class:io.github.kaii_lb.Overskride"
        "center,class:io.github.kaii_lb.Overskride"

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

        "float,class:com.system76.CosmicFiles"
        "center,class:com.system76.CosmicFiles"
        "size 60% 60%,class:com.system76.CosmicFiles"

        "float,class:com.vysp3r.ProtonPlus"
        "center,class:com.vysp3r.ProtonPlus"
        "size 60% 60%,class:com.vysp3r.ProtonPlus"

        "dimaround,class:io.elementary.desktop.agent-polkit"
        "pin,class:io.elementary.desktop.agent-polkit"
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

        "SUPER,Return,        exec, ${uwsm} app -- ${ghostty}"
        ''SUPER,d,            exec, ${rofi} -show drun -run-command "${uwsm} app -- {cmd}"''
        "SUPER,e,             exec, ${uwsm} app -- ${ghostty} --class=yazi -e ${yazi}"
        "SUPER,i,             exec, ${uwsm} app -- ${firefox}"
        "SUPER_SHIFT,i,       exec, ${uwsm} app -- ${librewolf}"

        "SUPER_SHIFT,escape,  exec, ${pkgs.misc-scripts}/bin/power-menu"
        "SUPER_SHIFT,b,       exec, ${uwsm} app -- ${overskride}"

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
        ",print,             exec, ${grimblast} --notify save screen"
        "SHIFT,print,        exec, ${grimblast} --notify --freeze save area"
      ];

      binde = [
        ",XF86AudioRaiseVolume,  exec, ${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,  exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
    };
  };
}
