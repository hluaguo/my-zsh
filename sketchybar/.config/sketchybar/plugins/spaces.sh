#!/bin/bash

source "$CONFIG_DIR/colors.sh"

FOCUSED_WS=$(aerospace list-workspaces --focused 2>/dev/null)

for sid in 1 2 3 4; do
  # Update highlight state
  if [ "$sid" = "$FOCUSED_WS" ]; then
    sketchybar --set space.$sid \
      icon.highlight=on \
      label.highlight=on \
      background.border_color=$ACCENT \
      background.border_width=2
  else
    sketchybar --set space.$sid \
      icon.highlight=off \
      label.highlight=off \
      background.border_color=$BACKGROUND_2 \
      background.border_width=0
  fi

  # Update app icons
  APPS=$(aerospace list-windows --workspace "$sid" --format '%{app-name}' 2>/dev/null | sort -u)

  icon_strip=""
  while IFS= read -r app; do
    [ -z "$app" ] && continue
    icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
  done <<< "$APPS"

  if [ -z "$icon_strip" ]; then
    icon_strip=" —"
  fi

  sketchybar --set space.$sid label="$icon_strip"
done
