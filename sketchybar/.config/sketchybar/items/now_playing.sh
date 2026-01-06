#!/bin/bash

sketchybar --add item now_playing right \
  --set now_playing \
    icon=󰎆 \
    icon.font="$FONT:Bold:17.0" \
    icon.color=$MAGENTA \
    label.font="$FONT:Medium:15.0" \
    label.max_chars=30 \
    background.drawing=off \
    drawing=off \
    update_freq=3 \
    script="$PLUGIN_DIR/now_playing.sh"
