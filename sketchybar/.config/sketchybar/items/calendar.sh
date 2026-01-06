#!/bin/bash

sketchybar --add item calendar right \
  --set calendar \
    icon.font="$FONT:Bold:15.0" \
    label.font="$FONT:Bold:15.0" \
    update_freq=30 \
    background.color=$BACKGROUND_1 \
    background.drawing=on \
    script="$PLUGIN_DIR/calendar.sh" \
  --subscribe calendar system_woke
