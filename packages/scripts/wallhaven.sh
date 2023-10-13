#!/bin/sh

set -eu

DIR="${1:-/tmp}"
mkdir -p "$DIR"

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
if [ ! -e $CONFIG_DIR/wallpaper_config ]; then
  echo '{"tags":null,"categories":"100","purity":"100"}' | jq > $CONFIG_DIR/wallpaper_config
fi

TAGS="$(cat $CONFIG_DIR/wallpaper_config | jq -r '.tags // empty')"
if [ -n "$TAGS" ]; then
  TAGS="q=$TAGS&"
fi

CATEGORIES="$(cat $CONFIG_DIR/wallpaper_config | jq -r '.categories // empty')"
if [ -n "$CATEGORIES" ]; then
  CATEGORIES="categories=$CATEGORIES&"
fi

PURITY="$(cat $CONFIG_DIR/wallpaper_config | jq -r '.purity // empty')"
if [ -n "$PURITY" ]; then
  PURITY="purity=$PURITY&"
fi

WALLHAVEN_API_KEY="$(secret-tool lookup application wallhaven-api-key)"
if [ -n "$WALLHAVEN_API_KEY" ]; then
  WALLHAVEN_API_KEY="apikey=$WALLHAVEN_API_KEY&"
fi

notify-send -r 9897 -i information -t 1000 "Wallpapers" "Downloading..."
URL="https://wallhaven.cc/api/v1/search?${WALLHAVEN_API_KEY}${TAGS}${CATEGORIES}${PURITY}atleast=3840x2160&ratios=16x9&sorting=random"
ID="$(curl --silent "$URL" | jq -r '.data[0].id')"
IMAGE_META=$(curl --silent "https://wallhaven.cc/api/v1/w/$ID")
IMAGE_URL="$(echo "$IMAGE_META" | jq -r '.data.path')"
IMAGE_ID="$(echo "$IMAGE_META" | jq -r '.data.id')"
FILENAME="wallhaven-$IMAGE_ID"
curl --silent -L --output "/tmp/$FILENAME" "$IMAGE_URL"
convert "/tmp/$FILENAME" "$DIR/$FILENAME.jpg"
echo "$DIR/$FILENAME.jpg"

