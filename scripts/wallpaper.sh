#!/bin/bash

WALLPAPER="$HOME/Pictures/wallpapers/festa-della-sedia-fortunato-depero-gruvbox-material.png"

for output in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    xwallpaper --output "$output" --zoom "$WALLPAPER"
done
