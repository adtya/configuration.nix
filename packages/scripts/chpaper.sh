#!/bin/sh

set -eu

DIR="${1:-}"
if [ -z "$DIR" ]; then
  echo "Usage: $0 <path to directory containing wallpapers>"
  exit 1
fi

random_paper() {
  if [ -d "$DIR" ] ; then
    find -L "${DIR}"/ -type f -regextype egrep -regex ".*\.(jpe?g|png)$" | shuf -n1
  elif [ -f "$DIR" ] ; then
    echo "$DIR"
  fi
}

swww query || swww init
convert "$(random_paper)" /tmp/wallpaper.jpg && swww img --transition-type random --transition-duration 1 "/tmp/wallpaper.jpg"
convert "$(random_paper)" /tmp/lockpaper.jpg

notify-send -r 9897 -i information -t 1000 "Wallpaper" "Wallpaper changed."
