#!/bin/bash

source "$CONFIG_DIR/colors.sh"

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

case ${PERCENTAGE} in
  9[0-9]|100) ICON="󰁹"; COLOR=$GREEN ;;
  [6-8][0-9]) ICON="󰂁"; COLOR=$WHITE ;;
  [3-5][0-9]) ICON="󰁿"; COLOR=$WHITE ;;
  [1-2][0-9]) ICON="󰁻"; COLOR=$ORANGE ;;
  *) ICON="󰁺"; COLOR=$RED ;;
esac

if [[ -n "$CHARGING" ]]; then
  ICON="󰂄"
  COLOR=$GREEN
fi

sketchybar --set $NAME icon="$ICON" icon.color=$COLOR label="${PERCENTAGE}%"
