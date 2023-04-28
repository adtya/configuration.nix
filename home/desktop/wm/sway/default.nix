{ config, lib, pkgs, ... }: {

  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    wrapperFeatures.gtk = true;
    xwayland = true;
    config = {
      modifier = "Mod4";
      fonts = {
        names = [ "FiraCode Nerd Font" ];
        size = 11.0;
      };
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
      };
      bars = [ ];
      gaps = {
        outer = 2;
        inner = 2;
      };
      window.titlebar = false;
      floating.titlebar = false;
      colors = {
        background = "#F8F8F2";
        focused = {
          background = "#6272A4";
          border = "#6272A4";
          childBorder = "#6272A4";
          indicator = "#6272A4";
          text = "#F8F8F2";
        };
        focusedInactive = {
          background = "#44475A";
          border = "#44475A";
          childBorder = "#44475A";
          indicator = "#44475A";
          text = "#F8F8F2";
        };
        placeholder = {
          background = "#282A36";
          border = "#282A36";
          childBorder = "#282A36";
          indicator = "#282A36";
          text = "#F8F8F2";
        };
        unfocused = {
          background = "#282A36";
          border = "#282A36";
          childBorder = "#282A36";
          indicator = "#282A36";
          text = "#BFBFBF";
        };
        urgent = {
          background = "#FF5555";
          border = "#44475A";
          childBorder = "#FF5555";
          indicator = "#FF5555";
          text = "#F8F8F2";
        };
      };

      seat = {
        "*" = {
          xcursor_theme = "Bibata-Modern-Classic 24";
        };
      };

      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;

          brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
          grim = "${pkgs.grim}/bin/grim";
          kitty = "${config.programs.kitty.package}/bin/kitty";
          playerctl = "${pkgs.playerctl}/bin/playerctl";
          rofi = "${config.programs.rofi.package}/bin/rofi";
          tmux = "${config.programs.tmux.package}/bin/tmux";
          slurp = "${pkgs.slurp}/bin/slurp";
          swaylock = "${pkgs.swaylock}/bin/swaylock";
          wpctl = "${pkgs.wireplumber}/bin/wpctl";
          xdg-user-dir = "${pkgs.xdg-user-dirs}/bin/xdg-user-dir";
          change-wallpaper = "${pkgs.scripts}/bin/chpaper \${HOME}/Pictures/Wallpapers";
        in
        lib.mkOptionDefault {
          "${modifier}+Return" = "exec ${kitty} ${tmux} new";
          "${modifier}+Shift+Return" = "exec ${kitty}";
          "${modifier}+d" = "exec ${rofi} -show drun";
          "${modifier}+Shift+c" = "reload";
          "${modifier}+l" = "exec ${swaylock} -f -i /tmp/lockpaper.jpg";
          "${modifier}+Shift+w" = "exec ${change-wallpaper}";
          "${modifier}+Shift+escape" = "exec ${pkgs.scripts}/bin/power-menu";
          "${modifier}+f11" = "exec ${pkgs.scripts}/bin/tmux-sessions";

          "XF86MonBrightnessUp" = "exec ${brightnessctl} set +5%";
          "XF86MonBrightnessDown" = "exec ${brightnessctl} set 5%-";

          "XF86AudioMute" = "exec ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioRaiseVolume" = "exec ${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume" = "exec ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-";

          "XF86AudioPlay" = "exec ${playerctl} play-pause";
          "XF86AudioNext" = "exec ${playerctl} next";
          "XF86AudioPrev" = "exec ${playerctl} previous";

          "print" = ''exec ${grim} "''$(${xdg-user-dir} PICTURES)/Screenshots/screenshot-''$(date +%Y-%m-%d-%H-%M-%S).png"'';
          "Shift+print" = ''exec ${grim} -g "''$(${slurp})" "''$(${xdg-user-dir} PICTURES)/Screenshots/screenshot-''$(date +%Y-%m-%d-%H-%M-%S).png"'';
        };

      startup = [
        { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
        {
          command = "${pkgs.scripts}/bin/chpaper \${HOME}/Pictures/Wallpapers";
          always = true;
        }
        {
          command = "systemctl --user restart waybar.service";
          always = true;
        }
        {
          command = "systemctl --user restart kanshi.service";
          always = true;
        }
      ];

      window.commands = [
        {
          command = "floating enable, focus";
          criteria = {
            app_id = "pavucontrol";
          };
        }
        {
          command = "floating enable, focus";
          criteria = {
            app_id = "blueman-manager";
          };
        }
        {
          command = "floating enable, focus";
          criteria = {
            app_id = "solaar";
          };
        }
        {
          command = "floating enable, focus, resize set width 95ppt";
          criteria = {
            app_id = "mpv";
          };
        }
        {
          command = "floating enable, focus";
          criteria = {
            app_id = "eog";
          };
        }
        {
          command = "floating enable, focus";
          criteria = {
            app_id = "io.elementary.files";
          };
        }
        {
          command = "floating enable, focus";
          criteria = {
            app_id = "gnome-system-monitor";
          };
        }
        {
          command = "floating enable, focus";
          criteria = {
            app_id = "virt-manager";
          };
        }
        {
          command = "floating enable, focus";
          criteria = {
            class = "1Password";
          };
        }
        {
          command = "floating enable, focus";
          criteria = {
            app_id = "io.github.celluloid_player.Celluloid";
          };
        }
        {
          command = "floating enable, focus";
          criteria = {
            app_id = "gnome-disks";
          };
        }
        {
          command = "floating enable, focus";
          criteria = {
            app_id = "yubico.org.";
          };
        }
        {
          command = "floating enable, focus";
          criteria = {
            app_id = ".yubioath-flutter-wrapped";
          };
        }
        {
          command = "move container to workspace 2, focus";
          criteria = {
            app_id = "firefox";
          };
        }
        {
          command = "move container to workspace 9, focus";
          criteria = {
            class = "Spotify";
          };
        }
      ];
    };
  };
}
