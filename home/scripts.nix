{ osConfig, pkgs, ... }:
let
  notify-send = "${pkgs.libnotify}/bin/notify-send";
  dmenu = "${pkgs.rofi-wayland}/bin/rofi -dmenu";
in
{
  xdg.configFile = {
    "scripts/chpaper.sh" = {
      text = ''
        #!/bin/sh

        set -eu

        DIR="''${HOME}/.local/share/wallpapers"

        random_paper() {
          find -L "''${DIR}"/ -type f -regextype egrep -regex ".*\.(jpe?g|png)$" | shuf -n1
        }

        SWAYSOCK="''${SWAYSOCK:-""}"
        if [ -z "''${SWAYSOCK}" ] ; then
          SWAYSOCK="$(find /run/user/"$(id -u)"/ -name "sway-ipc.$(id -u).*.sock")"
          export SWAYSOCK
        fi
        ${pkgs.imagemagick}/bin/convert "$(random_paper)" /tmp/wallpaper.jpg && swaymsg "output * bg '/tmp/wallpaper.jpg' fill" &
        ${pkgs.imagemagick}/bin/convert "$(random_paper)" /tmp/lockpaper.jpg
      '';
      executable = true;
    };
    "scripts/power_menu.sh" = {
      executable = true;
      text = ''
        #!/bin/sh

        set -eu

        chpower() {
          case "$1" in
            "")
            ;;
            Shutdown)
              exec systemctl poweroff
            ;;
            Reboot)
              exec systemctl reboot
            ;;
            Hibernate)
              exec systemctl hibernate
            ;;
            Logout)
              swaymsg exit
            ;;
            *)
              ${notify-send} -t 1500 -u low "Invalid Option"
            ;;
          esac
        }

        OPTIONS="Shutdown\nReboot\nHibernate\nLogout"

        chpower "$(printf "%b" "$OPTIONS" | sort | ${dmenu} -p "Power Menu")"
      '';
    };

    "scripts/volume_up.sh" =
      let
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
      in
      {
        executable = true;
        text = ''
          #!/bin/sh

          set -eu

          ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ 0
          [ $(${wpctl} get-volume @DEFAULT_AUDIO_SINK@ | awk -F': ' '{print $2}' | sed 's/\.//') -lt 100 ] && ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+
        '';
      };

    "scripts/tmux_sessions.sh" =
      let
        kitty = "${pkgs.kitty}/bin/kitty";
        tmux = "${pkgs.tmux}/bin/tmux";
      in
      {
        executable = true;
        text = ''
          #!/bin/sh

          set -eu

          SESSION="$(${tmux} list-sessions -F "(#{session_attached}) #S [#{pane_current_command} in #{pane_current_path}] #{pane_title}" | sort | ${dmenu} -p "Running TMUX Sessions" | awk '{print $2}')"
          case "$SESSION" in
            "")
              ;;
            *)
              ${kitty} ${tmux} -u attach-session -dEt "$SESSION"
              ;;
          esac'';
      };
    "scripts/power_profile.sh" =
      let
        sudo = "/run/wrappers/bin/sudo";
        cpupower = "${osConfig.boot.kernelPackages.cpupower}/bin/cpupower";
        powerprofilesctl = "${pkgs.power-profiles-daemon}/bin/powerprofilesctl";
      in
      {
        executable = true;
        text = ''
          #!/bin/sh

          set -eu

          POWER_PROFILE_FILE="$HOME/.cache/power_profile"
          POWER_PROFILE="powersave"

          if [ -f "$POWER_PROFILE_FILE" ]; then
            POWER_PROFILE="$(<$POWER_PROFILE_FILE)"
          fi

          case "$1" in
            "toggle")
              if [ "$POWER_PROFILE" == "powersave" ]; then
                ${sudo} ${cpupower} frequency-set --governor performance > /dev/null
                ${powerprofilesctl} set performance
                POWER_PROFILE="performance"
              elif [ "$POWER_PROFILE" == "performance" ]; then
                ${sudo} ${cpupower} frequency-set --governor powersave > /dev/null
                ${powerprofilesctl} set power-saver
                POWER_PROFILE="powersave"
              fi
              echo $POWER_PROFILE > $POWER_PROFILE_FILE
              ${notify-send} -u normal "Power Profile" "Switched to $POWER_PROFILE mode."
            ;;
            "icon")
              if [ "$POWER_PROFILE" == "powersave" ]; then
                echo "󰌪"
              elif [ "$POWER_PROFILE" == "performance" ]; then
                echo "󰓅"
              fi
            ;;
            *)
            ;;
          esac
        '';
      };
  };
}
