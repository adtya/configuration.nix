#!/bin/sh

set -eu
XDG_CACHE_HOME=${XDG_CACHE_HOME:-}
if [ -n "$XDG_CACHE_HOME" ] ; then
  HISTORY_FILE="$XDG_CACHE_HOME/ytfzf/search_hist"
else
  HISTORY_FILE="$HOME/.cache/ytfzf/search_hist"
fi
if [ ! -e "$HISTORY_FILE" ] ; then
  touch "$HISTORY_FILE"
fi
HISTORY="$(awk -F' ' '{$1="";$2="";$3="";print $0}' $HISTORY_FILE | sed 's/^\s*//g' | uniq)"
SEARCH_TERM="$(echo "$HISTORY" | rofi -dmenu -p "Search Youtube:")"
kitty --class=ytfzf --title "YouTube Search: ${SEARCH_TERM}" -- ytfzf -f -tT kitty --async-thumbnails "${SEARCH_TERM}"

