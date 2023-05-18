#!/bin/sh

set -eu

DIR="${1:-}"
if [ -z "$DIR" ]; then
  echo "Usage: $0 <path to directory containing wallpapers>"
  exit 1
fi
if [ ! -d "$DIR" ]; then
  echo "$DIR: not a directory"
  exit 1
fi

random_paper() {
  find -L "${DIR}"/ -type f -regextype egrep -regex ".*\.(jpe?g|png)$" | shuf -n1
}

swww query || swww init
convert "$(random_paper)" /tmp/wallpaper.jpg && swww img "/tmp/wallpaper.jpg"
convert "$(random_paper)" /tmp/lockpaper.jpg

notify-send -r 9897 -i information -t 1000 "Wallpaper" "Wallpaper changed."
