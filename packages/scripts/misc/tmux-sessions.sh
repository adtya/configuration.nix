#!/bin/sh

set -eu

SESSION="$(tmux list-sessions -F "(#{session_attached}) #S [#{pane_current_command} in #{pane_current_path}] #{pane_title}" | sort | rofi -dmenu -p "Running TMUX Sessions" | awk '{print $2}')"
case "$SESSION" in
"") ;;
*)
  kitty tmux attach-session -dEt "$SESSION"
  ;;
esac
