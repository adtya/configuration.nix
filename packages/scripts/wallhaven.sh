#!/bin/sh

set -eu

DIR="${1:-/tmp}"
mkdir -p "$DIR"

notify-send -r 9897 -i information -t 1000 "Wallpapers" "Downloading..."
URL="https://wallhaven.cc/api/v1/search?categories=100&purity=100&atleast=3840x2160&ratios=16x9&sorting=random"
ID="$(curl --silent "$URL" | jq -r '.data[0].id')"
IMAGE_META=$(curl --silent "https://wallhaven.cc/api/v1/w/$ID")
IMAGE_URL="$(echo "$IMAGE_META" | jq -r '.data.path')"
IMAGE_ID="$(echo "$IMAGE_META" | jq -r '.data.id')"
FILENAME="wallhaven-$IMAGE_ID"
curl --silent -L --output "/tmp/$FILENAME" "$IMAGE_URL"
convert "/tmp/$FILENAME" "$DIR/$FILENAME.jpg"
echo "$DIR/$FILENAME.jpg"

