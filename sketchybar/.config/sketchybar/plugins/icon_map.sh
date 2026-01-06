#!/bin/bash

APP="$1"

case "$APP" in
  "1Password") echo ":1password:" ;;
  "Activity Monitor") echo ":activity_monitor:" ;;
  "Alacritty") echo ":alacritty:" ;;
  "App Store") echo ":app_store:" ;;
  "Arc") echo ":arc:" ;;
  "Calendar") echo ":calendar:" ;;
  "Claude") echo ":claude:" ;;
  "Code" | "Visual Studio Code") echo ":code:" ;;
  "Discord") echo ":discord:" ;;
  "Figma") echo ":figma:" ;;
  "Finder") echo ":finder:" ;;
  "Firefox") echo ":firefox:" ;;
  "Google Chrome") echo ":google_chrome:" ;;
  "iTerm2" | "iTerm") echo ":iterm:" ;;
  "Keynote") echo ":keynote:" ;;
  "kitty") echo ":kitty:" ;;
  "Mail") echo ":mail:" ;;
  "Messages") echo ":messages:" ;;
  "Music") echo ":music:" ;;
  "Notes") echo ":notes:" ;;
  "Notion") echo ":notion:" ;;
  "Numbers") echo ":numbers:" ;;
  "Obsidian") echo ":obsidian:" ;;
  "Pages") echo ":pages:" ;;
  "Preview") echo ":preview:" ;;
  "Raycast") echo ":raycast:" ;;
  "Reminders") echo ":reminders:" ;;
  "Safari") echo ":safari:" ;;
  "Slack") echo ":slack:" ;;
  "Spotify") echo ":spotify:" ;;
  "System Preferences" | "System Settings") echo ":system_preferences:" ;;
  "Terminal") echo ":terminal:" ;;
  "Warp") echo ":warp:" ;;
  "WebStorm") echo ":webstorm:" ;;
  "Xcode") echo ":xcode:" ;;
  "Zed") echo ":zed:" ;;
  "zoom.us") echo ":zoom:" ;;
  *) echo ":default:" ;;
esac
