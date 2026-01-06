#!/bin/bash

sketchybar --add item volume right \
  --set volume \
    icon=󰕾 \
    icon.font="$FONT:Bold:17.0" \
    icon.color=$BLUE \
    label.font="$FONT:Medium:15.0" \
    background.drawing=off \
    script="$PLUGIN_DIR/volume.sh" \
  --subscribe volume volume_change
