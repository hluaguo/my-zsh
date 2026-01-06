#!/bin/bash

source "$CONFIG_DIR/colors.sh"

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [ "$MUTED" = "true" ] || [ "$VOLUME" -eq 0 ]; then
  ICON="󰝟"
  COLOR=$GREY
elif [ "$VOLUME" -lt 30 ]; then
  ICON="󰕿"
  COLOR=$BLUE
elif [ "$VOLUME" -lt 70 ]; then
  ICON="󰖀"
  COLOR=$BLUE
else
  ICON="󰕾"
  COLOR=$BLUE
fi

sketchybar --set $NAME icon="$ICON" icon.color=$COLOR label="${VOLUME}%"
