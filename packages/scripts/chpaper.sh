#!/bin/sh

set -eu

DIR="${1:-}"
if [ -z "$DIR" ]; then
  echo "Usage: $0 <path to directory containing wallpapers>"
  exit 1
fi

random_paper() {
  if [ -d "$DIR" ] ; then
    find -L "${DIR}"/ -type f -regextype egrep -regex ".*\.(jpe?g|png)$" | shuf -n1 --random-source=/dev/urandom
  elif [ -f "$DIR" ] ; then
    echo "$DIR"
  fi
}

convert "$(random_paper)" /tmp/wallpaper.jpg && swww img --transition-step 2 --transition-type random --transition-duration 1 "/tmp/wallpaper.jpg"

