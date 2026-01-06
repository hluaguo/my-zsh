#!/bin/bash

source "$CONFIG_DIR/colors.sh"

PLAYING=""
APP=""

# Check Spotify
if pgrep -x "Spotify" > /dev/null; then
  STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)
  if [ "$STATE" = "playing" ]; then
    TRACK=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)
    ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)
    PLAYING="$TRACK - $ARTIST"
    APP="spotify"
  fi
fi

# Check Apple Music if Spotify not playing
if [ -z "$PLAYING" ] && pgrep -x "Music" > /dev/null; then
  STATE=$(osascript -e 'tell application "Music" to player state as string' 2>/dev/null)
  if [ "$STATE" = "playing" ]; then
    TRACK=$(osascript -e 'tell application "Music" to name of current track as string' 2>/dev/null)
    ARTIST=$(osascript -e 'tell application "Music" to artist of current track as string' 2>/dev/null)
    PLAYING="$TRACK - $ARTIST"
    APP="music"
  fi
fi

if [ -n "$PLAYING" ]; then
  case "$APP" in
    "spotify") ICON="󰓇"; COLOR=$GREEN ;;
    "music") ICON="󰎆"; COLOR=$MAGENTA ;;
  esac
  sketchybar --set $NAME drawing=on icon="$ICON" icon.color=$COLOR label="$PLAYING"
else
  sketchybar --set $NAME drawing=off
fi
