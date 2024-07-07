#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="/path/to/your/wallpapers"

# Time interval in seconds
INTERVAL=900

# Set the display environment variable
export DISPLAY=:0

# Ensure the DBUS_SESSION_BUS_ADDRESS is set
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus

while true; do
   for WALLPAPER in "$WALLPAPER_DIR"/*; do
       echo "Setting wallpaper to $WALLPAPER" >> /tmp/wallpaper.log
       gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER" >> /tmp/wallpaper.log 2>&1
       sleep $INTERVAL
   done
done

