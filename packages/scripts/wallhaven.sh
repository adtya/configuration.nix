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
CONFIG_FILE="${CONFIG_DIR}/wallpaper_config.json"
if [ ! -e ${CONFIG_FILE} ]; then
  printf '{"tags":null,"categories":"100","purity":"100", "sorting":"random", "size":null, "ratios":null, "colors":null, "ai_filter":1, "range": "1M"}' | jq > ${CONFIG_FILE}
fi

CONFIG="$(cat "${CONFIG_FILE}")"

AI_FILTER="$(printf "${CONFIG}" | jq -r '.ai_filter // empty')"
if [ -n "${AI_FILTER}" ]; then
  AI_FILTER="ai_art_filter=${AI_FILTER}&"
fi

TAGS="$(printf "${CONFIG}" | jq -r '.tags // empty')"
if [ -n "${TAGS}" ]; then
  TAGS="q=$(echo ${TAGS} | sed -e 's/ /%20/g' -e 's/+/%2B/g' -e 's/-/%2D/g' -e 's/:/%3A/g')&"
fi

CATEGORIES="$(printf "${CONFIG}" | jq -r '.categories // empty')"
if [ -n "${CATEGORIES}" ]; then
  CATEGORIES="categories=${CATEGORIES}&"
fi

PURITY="$(printf "${CONFIG}" | jq -r '.purity // empty')"
if [ -n "${PURITY}" ]; then
  PURITY="purity=${PURITY}&"
fi

SIZE="$(printf "${CONFIG}" | jq -r '.size // empty')"
if [ -n "${SIZE}" ]; then
  SIZE="atleast=${SIZE}&"
fi

RATIOS="$(printf "${CONFIG}" | jq -r '.ratios // empty')"
if [ -n "${RATIOS}" ]; then
  RATIOS="ratios=${RATIOS}&"
fi

COLORS="$(printf "${CONFIG}" | jq -r '.colors // empty')"
if [ -n "${COLORS}" ]; then
  COLORS="colors=${COLORS}&"
fi

SORTING="$(printf "${CONFIG}" | jq -r '.sorting // empty')"
if [ -n "${SORTING}" ]; then
  SORTING="sorting=${SORTING}&"
fi

RANGE="$(printf "${CONFIG}" | jq -r '.range // empty')"
if [ -n "${RANGE}" ]; then
  RANGE="topRange=${RANGE}&"
fi

notify-send -u normal -a Wallpapers -i information -t 2000 "Wallpapers" "Fetching a list of wallpapers..."
URL="${WALLHAVEN_BASE_URL}/search?${TAGS}${CATEGORIES}${PURITY}${SIZE}${RATIOS}${COLORS}${AI_FILTER}${SORTING}${RANGE}"
CURL_CMD="${CURL_BASE_CMD} \"${URL}\""
RESULT="$(eval ${CURL_CMD})"
NO_OF_IMAGES="$(printf "${RESULT}" | jq -r '.data | length')"
RANDOM_ITEM="$(shuf -i 1-${NO_OF_IMAGES} -n 1 --random-source=/dev/urandom)"
ID="$(printf "${RESULT}" | jq -r ".data[$((RANDOM_ITEM-1))].id")"
notify-send -u normal -a Wallpapers -i information -t 2000 "Wallpapers" "Got ${NO_OF_IMAGES} images. Using image ${RANDOM_ITEM} with id ${ID}..."
CURL_CMD="${CURL_BASE_CMD} \"${WALLHAVEN_BASE_URL}/w/${ID}\""
IMAGE_META=$(eval ${CURL_CMD})
IMAGE_URL="$(printf "${IMAGE_META}" | jq -r '.data.path')"
IMAGE_ID="$(printf "${IMAGE_META}" | jq -r '.data.id')"
FILENAME="wallhaven-${IMAGE_ID}"
notify-send -u normal -a Wallpapers -i information -t 2000 "Wallpapers" "Downloading image: ${IMAGE_URL}"
curl --silent -L --output "${DIR}/${FILENAME}.image" "${IMAGE_URL}"
notify-send -u normal -a Wallpapers -i information -t 2000 "Wallpapers" "Downloaded image: ${DIR}/${FILENAME}.image"
echo "${DIR}/${FILENAME}.image"

