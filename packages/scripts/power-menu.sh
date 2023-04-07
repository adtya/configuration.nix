#!/bin/sh

set -eu

SWAYSOCK=${SWAYSOCK:-}
HYPRLAND_INSTANCE_SIGNATURE=${HYPRLAND_INSTANCE_SIGNATURE:-}

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
      [ -n "$SWAYSOCK" ] && swaymsg exit
      [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ] && hyprctl dispatch exit
    ;;
    *)
      notify-send -t 1500 -u low "Invalid Option"
    ;;
  esac
}

OPTIONS="Shutdown\nReboot\nHibernate\nLogout"

chpower "$(printf "%b" "$OPTIONS" | sort | rofi -dmenu -p "Power Menu")"

