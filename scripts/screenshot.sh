#!/bin/bash

dir="$HOME/Pictures/screenshots"
mkdir -p "$dir"
timestamp=$(date +%d-%m-%Y_%H-%M-%S)

case "$1" in
    full)
        maim "$dir/screenshot_$timestamp.png"
        ;;
    select)
        maim -s "$dir/screenshot_$timestamp.png"
        ;;
    clipboard)
        maim | xclip -selection clipboard -t image/png
        ;;
    *)
        echo "Usage: $0 {full|select|clipboard}"
        ;;
esac

