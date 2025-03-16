#!/bin/sh

set -eu

HYPRLAND_INSTANCE_SIGNATURE=${HYPRLAND_INSTANCE_SIGNATURE:-}
NIRI_SOCKET=${NIRI_SOCKET:-}

chpower() {
  case "$1" in
  "") ;;
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
    [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ] && hyprctl dispatch exit
    [ -n "$NIRI_SOCKET" ] && niri msg action quit
    ;;
  *)
    notify-send -t 1500 -u low "Invalid Option"
    ;;
  esac
}

OPTIONS="Shutdown\nReboot\nHibernate\nLogout"

chpower "$(printf "%b" "$OPTIONS" | sort | rofi -dmenu -p "Power Menu")"
