#!/bin/bash

# Get app icons for a specific space
SPACE_ID=$1

if [ -z "$SPACE_ID" ]; then
  SPACE_ID=$SID
fi

# Query yabai for windows in this space
WINDOWS=$(yabai -m query --windows --space $SPACE_ID 2>/dev/null)

if [ -z "$WINDOWS" ] || [ "$WINDOWS" = "[]" ]; then
  sketchybar --set space.$SPACE_ID label=""
  exit 0
fi

# Map app names to nerd font icons
get_icon() {
  case "$1" in
    "Google Chrome") echo "󰊯" ;;
    "Safari") echo "󰀹" ;;
    "Firefox") echo "󰈹" ;;
    "iTerm2") echo "" ;;
    "Terminal") echo "" ;;
    "Code") echo "󰨞" ;;
    "Visual Studio Code") echo "󰨞" ;;
    "Slack") echo "󰒱" ;;
    "Discord") echo "󰙯" ;;
    "Finder") echo "󰀶" ;;
    "Messages") echo "󰍡" ;;
    "Mail") echo "󰇮" ;;
    "Obsidian") echo "󰠗" ;;
    "Notion") echo "󰈙" ;;
    "Spotify") echo "󰓇" ;;
    "Music") echo "󰎆" ;;
    "Preview") echo "󰋩" ;;
    "Notes") echo "󰎞" ;;
    "Calendar") echo "󰃭" ;;
    *) echo "󰘔" ;;
  esac
}

# Get unique app names and their icons
ICONS=""
APPS=$(echo "$WINDOWS" | jq -r '.[].app' | sort -u)

while IFS= read -r app; do
  [ -z "$app" ] && continue
  ICONS+="$(get_icon "$app") "
done <<< "$APPS"

sketchybar --set space.$SPACE_ID label="$ICONS"
