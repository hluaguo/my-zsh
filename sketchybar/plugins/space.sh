#!/bin/sh

PLUGIN_DIR="$CONFIG_DIR/plugins"

# Tokyo Night colors
ACCENT=0xff7aa2f7
ITEM_BG=0xff292e42

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" background.drawing=on background.color=$ACCENT
else
  sketchybar --set "$NAME" background.drawing=on background.color=$ITEM_BG
fi

# Update app icons for this space
SID=$(echo "$NAME" | cut -d. -f2)
"$PLUGIN_DIR/space_windows.sh" "$SID"
