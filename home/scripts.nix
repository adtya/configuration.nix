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
  };
}
