#!/bin/sh

set -eu
XDG_CACHE_HOME=${XDG_CACHE_HOME:-}
if [ -n "$XDG_CACHE_HOME" ] ; then
  HISTORY_FILE="$XDG_CACHE_HOME/youtube_history"
else
  HISTORY_FILE="$HOME/.cache/youtube_history"
fi
if [ ! -e "$HISTORY_FILE" ] ; then
  touch "$HISTORY_FILE"
fi
SEARCH_TERM="$(rofi -dmenu -p "Search Youtube:" < "$HISTORY_FILE")"
echo "$SEARCH_TERM" >> $HISTORY_FILE
kitty --class=ytfzf --title "YouTube Search: ${SEARCH_TERM}" -- ytfzf -f -tT kitty --async-thumbnails "${SEARCH_TERM}"

