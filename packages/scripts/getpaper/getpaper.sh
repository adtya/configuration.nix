#!/bin/sh

set -eu

WALLHAVEN_BASE_URL="https://wallhaven.cc/api/v1"

WALLHAVEN_API_KEY="$(secret-tool lookup application wallhaven-api-key)"
if [ -n "${WALLHAVEN_API_KEY}" ]; then
  API_KEY_HEADER="-H \"X-API-Key: ${WALLHAVEN_API_KEY}\""
fi

CURL_BASE_CMD="curl --silent ${API_KEY_HEADER}"

CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}"
CONFIG_FILE="${CONFIG_DIR}/wallpaper_config.json"
if [ ! -e "${CONFIG_FILE}" ]; then
  echo '{"tags":null,"categories":"100","purity":"100", "sorting":"random", "size":null, "ratios":null, "colors":null, "ai_filter":1, "range": "1M", "look_at": 120}' | jq >"${CONFIG_FILE}"
fi

CONFIG="$(cat "${CONFIG_FILE}")"

DIR="${1:-}"
if [ -z "${DIR}" ]; then
  DIR="${XDG_PICTURES_DIR:-${HOME}/Pictures}/Wallpapers"
  echo "Warning: wallpaper directory not set. using fallback directory ${DIR}" >&2
fi

DIR="$(echo "${DIR}" | envsubst)"
mkdir -p "${DIR}"

AI_FILTER="$(echo "${CONFIG}" | jq -r '.ai_filter // empty')"
if [ -n "${AI_FILTER}" ]; then
  AI_FILTER="ai_art_filter=${AI_FILTER}&"
fi

TAGS="$(echo "${CONFIG}" | jq -r '.tags // empty')"
if [ -n "${TAGS}" ]; then
  TAGS="q=$(echo "${TAGS}" | sed -e 's/ /%20/g' -e 's/+/%2B/g' -e 's/-/%2D/g' -e 's/:/%3A/g')&"
fi

CATEGORIES="$(echo "${CONFIG}" | jq -r '.categories // empty')"
if [ -n "${CATEGORIES}" ]; then
  CATEGORIES="categories=${CATEGORIES}&"
fi

PURITY="$(echo "${CONFIG}" | jq -r '.purity // empty')"
if [ -n "${PURITY}" ] && [ -n "${API_KEY_HEADER}" ]; then
  PURITY="purity=${PURITY}&"
fi

SIZE="$(echo "${CONFIG}" | jq -r '.size // empty')"
if [ -n "${SIZE}" ]; then
  SIZE="atleast=${SIZE}&"
fi

RATIOS="$(echo "${CONFIG}" | jq -r '.ratios // empty')"
if [ -n "${RATIOS}" ]; then
  RATIOS="ratios=${RATIOS}&"
fi

COLORS="$(echo "${CONFIG}" | jq -r '.colors // empty')"
if [ -n "${COLORS}" ]; then
  COLORS="colors=${COLORS}&"
fi

SORTING="$(echo "${CONFIG}" | jq -r '.sorting // empty')"
if [ -n "${SORTING}" ]; then
  SORTING="sorting=${SORTING}&"
fi

RANGE="$(echo "${CONFIG}" | jq -r '.range // empty')"
if [ -n "${RANGE}" ]; then
  RANGE="topRange=${RANGE}&"
fi

LOOK_AT="$(echo "${CONFIG}" | jq -r '.look_at // empty')"
if [ -z "${LOOK_AT}" ]; then
  LOOK_AT=120
fi

URL="${WALLHAVEN_BASE_URL}/search?${TAGS}${CATEGORIES}${PURITY}${SIZE}${RATIOS}${COLORS}${AI_FILTER}${SORTING}${RANGE}"
CURL_CMD="${CURL_BASE_CMD} \"${URL}\""
RESULT="$(eval "${CURL_CMD}")"
NO_OF_IMAGES="$(echo "${RESULT}" | jq -r '.meta.total')"
if [ "${NO_OF_IMAGES}" -eq 0 ]; then
  echo "No wallpapers available for current configuration" >&2
  exit 1
fi
if [ "${NO_OF_IMAGES}" -gt "${LOOK_AT}" ]; then
  NO_OF_IMAGES=$LOOK_AT
fi
RANDOM_ITEM="$(shuf -i 0-$((NO_OF_IMAGES - 1)) -n 1 --random-source=/dev/urandom)"
ITEM_PAGE=$((RANDOM_ITEM / 24))
ITEM_NUMBER=$((RANDOM_ITEM % 24))
if [ "${ITEM_PAGE}" -gt 0 ]; then
  SEED="$(echo "${RESULT}" | jq -r '.meta.seed // empty')"
  if [ -n "${SEED}" ]; then
    SEED="seed=${SEED}&"
  fi
  CURL_CMD="${CURL_BASE_CMD} \"${URL}${SEED}page=$((ITEM_PAGE + 1))\""
  RESULT="$(eval "${CURL_CMD}")"
fi
IMAGE_URL="$(echo "${RESULT}" | jq -r ".data[${ITEM_NUMBER}].path")"
FILENAME="${IMAGE_URL##*/}"
if [ ! -f "${DIR}/${FILENAME}" ]; then
  curl --silent -L --output-dir "${DIR}" -o "${FILENAME}" "${IMAGE_URL}"
fi
echo "${DIR}/${FILENAME}"
