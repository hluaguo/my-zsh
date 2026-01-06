#!/bin/bash

for sid in 1 2 3 4; do
  sketchybar --add item space.$sid left \
    --set space.$sid \
    icon=$sid \
    icon.padding_left=12 \
    icon.padding_right=12 \
    icon.highlight_color=$ACCENT \
    label.padding_right=20 \
    label.color=$GREY \
    label.highlight_color=$WHITE \
    label.font="sketchybar-app-font:Regular:14.0" \
    background.color=$BACKGROUND_1 \
    background.drawing=on \
    click_script="aerospace workspace $sid"
done

sketchybar --add item spaces_trigger left \
  --set spaces_trigger drawing=off script="$PLUGIN_DIR/spaces.sh" \
  --subscribe spaces_trigger aerospace_workspace_change front_app_switched

sketchybar --add item space_separator left \
  --set space_separator icon="󰅂" icon.color=$ACCENT icon.padding_left=8 icon.padding_right=8 background.drawing=off label.drawing=off
