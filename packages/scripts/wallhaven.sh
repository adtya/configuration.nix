#!/bin/sh

set -eu

wallpaper() {
  FILENAME="/tmp/image-${RANDOM}"

  notify-send -r 9897 -i information -t 1000 "Wallpapers" "Downloading..."
  URL="https://wallhaven.cc/api/v1/search?categories=100&purity=100&atleast=1920x1080&ratios=16x9&sorting=random"
  ID="$(curl --silent $URL | jq -r '.data[0].id')"
  IMAGE_URL="$(curl --silent "https://wallhaven.cc/api/v1/w/$ID" | jq -r '.data.path')"

  curl --silent -L --output "$FILENAME" "$IMAGE_URL"
  echo $FILENAME
}

swww query || swww init
convert "$(wallpaper)" "/tmp/wallpaper.jpg" && swww img "/tmp/wallpaper.jpg"
convert "$(wallpaper)" "/tmp/lockpaper.jpg"

notify-send -r 9897 -i information -t 1000 "Wallpaper" "Wallpaper changed."
