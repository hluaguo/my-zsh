#!/bin/bash

sketchybar --add item front_app left \
  --set front_app \
    label.font="$FONT:Bold:12.0" \
    icon.background.drawing=on \
    icon.background.image.scale=0.8 \
    background.drawing=off \
    script="$PLUGIN_DIR/front_app.sh" \
  --subscribe front_app front_app_switched
