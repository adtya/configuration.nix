#!/bin/sh

set -eu

WALLHAVEN_BASE_URL="https://wallhaven.cc/api/v1"

WALLHAVEN_API_KEY="$(secret-tool lookup application wallhaven-api-key)"
if [ -n "${WALLHAVEN_API_KEY}" ]; then
  API_KEY_HEADER="-H \"X-API-Key: ${WALLHAVEN_API_KEY}\""
fi

CURL_BASE_CMD="curl --silent ${API_KEY_HEADER}"

DIR="${1:-/tmp}"
mkdir -p "${DIR}"

CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}"
if [ ! -e ${CONFIG_DIR}/wallpaper_config.json ]; then
  echo '{"tags":null,"categories":"100","purity":"100", "sorting":"random", "size":null, "ratios":null, "colors":null}' | jq > ${CONFIG_DIR}/wallpaper_config.json
fi

TAGS="$(cat ${CONFIG_DIR}/wallpaper_config.json | jq -r '.tags // empty')"
if [ -n "${TAGS}" ]; then
  TAGS="q=$(echo ${TAGS} | sed -e 's/ /%20/g' -e 's/+/%2B/g' -e 's/-/%2D/g')&"
fi

CATEGORIES="$(cat ${CONFIG_DIR}/wallpaper_config.json | jq -r '.categories // empty')"
if [ -n "${CATEGORIES}" ]; then
  CATEGORIES="categories=${CATEGORIES}&"
fi

PURITY="$(cat ${CONFIG_DIR}/wallpaper_config.json | jq -r '.purity // empty')"
if [ -n "${PURITY}" ]; then
  PURITY="purity=${PURITY}&"
fi

SIZE="$(cat ${CONFIG_DIR}/wallpaper_config.json | jq -r '.size // empty')"
if [ -n "${SIZE}" ]; then
  SIZE="atleast=${SIZE}&"
fi

RATIOS="$(cat $CONFIG_DIR/wallpaper_config.json | jq -r '.ratios // empty')"
if [ -n "${RATIOS}" ]; then
  RATIOS="ratios=${RATIOS}&"
fi

COLORS="$(cat ${CONFIG_DIR}/wallpaper_config.json | jq -r '.colors // empty')"
if [ -n "${COLORS}" ]; then
  COLORS="colors=${COLORS}&"
fi

SORTING="$(cat ${CONFIG_DIR}/wallpaper_config.json | jq -r '.sorting // empty')"
if [ -n "${SORTING}" ]; then
  SORTING="sorting=${SORTING}&"
fi

notify-send -r 9897 -i information -t 1000 "Wallpapers" "Downloading..."
URL="${WALLHAVEN_BASE_URL}/search?${TAGS}${CATEGORIES}${PURITY}${SIZE}${RATIOS}${COLORS}${SORTING}"
CURL_CMD="${CURL_BASE_CMD} \"${URL}\""
ID="$(eval ${CURL_CMD} | jq -r '.data[0].id')"
CURL_CMD="${CURL_BASE_CMD} \"${WALLHAVEN_BASE_URL}/w/${ID}\""
IMAGE_META=$(eval ${CURL_CMD})
IMAGE_URL="$(echo "${IMAGE_META}" | jq -r '.data.path')"
IMAGE_ID="$(echo "${IMAGE_META}" | jq -r '.data.id')"
FILENAME="wallhaven-${IMAGE_ID}"
curl --silent -L --output "/tmp/${FILENAME}" "${IMAGE_URL}"
convert "/tmp/${FILENAME}" "${DIR}/${FILENAME}.jpg"
echo "${DIR}/${FILENAME}.jpg"

