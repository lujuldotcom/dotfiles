#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$1" in
    off)
        xrandr --output HDMI-1-0 --off \
               --output eDP-1 --mode 2560x1600 --rate 60 --primary
        ;;
    4k)
        xrandr --output eDP-1 --off \
               --output HDMI-1-0 --mode 3840x2160 --rate 60 --primary
        ;;
    dual4k)
        xrandr --output eDP-1 --mode 2560x1600 --rate 60 --primary \
               --output HDMI-1-0 --mode 3840x2160 --rate 60 --right-of eDP-1
        ;;
    mirror1080)
        xrandr --fb 1920x1080 \
               --output HDMI-1-0 --mode 1920x1080 --rate 60 \
               --output eDP-1 --mode 1920x1080 --rate 60 --same-as HDMI-1-0
        ;;
    mirror1440)
        xrandr --fb 2560x1440 \
               --output HDMI-1-0 --mode 2560x1440 --rate 60 \
               --output eDP-1 --mode 2560x1440 --rate 60 --same-as HDMI-1-0
        ;;
    *)
        echo "Usage: hdmi {off|4k|dual4k|mirror1080|mirror1440}"
        ;;
esac

"$SCRIPT_DIR"/wallpaper.sh
