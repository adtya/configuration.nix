#!/bin/sh

set -eu

DIR="$1"
if [ ! -d "$DIR" ]; then
  echo "$DIR: not a directory"
  exit 1
fi

random_paper() {
  find -L "${DIR}"/ -type f -regextype egrep -regex ".*\.(jpe?g|png)$" | shuf -n1
}

convert "$(random_paper)" /tmp/wallpaper.jpg && swaybg -i "/tmp/wallpaper.jpg" -m fill &
convert "$(random_paper)" /tmp/lockpaper.jpg
