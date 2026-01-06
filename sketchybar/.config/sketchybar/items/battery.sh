#!/bin/bash

sketchybar --add item battery right \
  --set battery \
    icon.font="$FONT:Bold:17.0" \
    label.font="$FONT:Medium:15.0" \
    update_freq=120 \
    background.drawing=off \
    script="$PLUGIN_DIR/battery.sh" \
  --subscribe battery power_source_change system_woke
