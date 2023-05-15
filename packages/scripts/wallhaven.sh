#!/bin/sh

set -eu

wallpaper() {
  FILENAME="/tmp/image-${RANDOM}"

  URL="https://wallhaven.cc/api/v1/search?categories=100&purity=100&atleast=1920x1080&ratios=16x9&sorting=random"
  ID="$(curl --silent $URL | jq -r '.data[0].id')"
  IMAGE_URL="$(curl --silent "https://wallhaven.cc/api/v1/w/$ID" | jq -r '.data.path')"

  curl --silent -L --output "$FILENAME" "$IMAGE_URL"
  echo $FILENAME
}

convert "$(wallpaper)" "/tmp/wallpaper.jpg" && (pkill swaybg; swaybg -i "/tmp/wallpaper.jpg" -m fill &)
convert "$(wallpaper)" "/tmp/lockpaper.jpg"
