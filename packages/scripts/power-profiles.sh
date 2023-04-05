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
      powerprofilesctl set performance
      POWER_PROFILE="performance"
    elif [ "$POWER_PROFILE" == "performance" ]; then
      powerprofilesctl set power-saver
      POWER_PROFILE="powersave"
    fi
    echo $POWER_PROFILE > $POWER_PROFILE_FILE
    notify-send -u normal "Power Profile" "Switched to $POWER_PROFILE mode."
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

