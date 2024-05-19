#!/bin/sh

set -eu

CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}"
CONFIG_FILE="${CONFIG_DIR}/wallpaper_config.json"
if [ ! -e "${CONFIG_FILE}" ]; then
  echo "Wallpaper config file: ${CONFIG_FILE} missing." >&2
  exit 1
fi

CONFIG="$(cat "${CONFIG_FILE}")"

DIR="$(echo "${CONFIG}" | jq -r '.dir // empty')"
if [ -z "${DIR}" ]; then
  DIR="${XDG_PICTURES_DIR:-${HOME}/Pictures}/Wallpapers"
  echo "Warning: wallpaper directory not set. using fallback directory ${DIR}" >&2
fi
DIR="$(echo "${DIR}" | envsubst)"
mkdir -p "${DIR}"

random_paper() {
  if [ -d "$DIR" ] ; then
    find -L "${DIR}"/ -type f -regextype egrep -regex ".*\.(jpe?g|png)$" | shuf -n1 --random-source=/dev/urandom
  else
    echo "${DIR} is not a directory" >&2
    exit 1
  fi
}

swww img \
  --transition-type random \
  --transition-step 2 \
  --transition-duration 2 \
  --transition-bezier "0.1,0.1,1.0,1.0" \
  "$(random_paper)"

