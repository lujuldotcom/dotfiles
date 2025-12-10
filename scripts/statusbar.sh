#!/bin/bash

BATTERY_DISPLAY=$(~/Projects/src/dotfiles/scripts/battery.sh)

INTERNET_DISPLAY=$(~/Projects/src/dotfiles/scripts/internet.sh)

MICROPHONE_DISPLAY=$(~/Projects/src/dotfiles/scripts/microphone.sh)
VOLUME_DISPLAY=$(~/Projects/src/dotfiles/scripts/volume.sh)

BRIGHTNESS=$(cat /sys/class/backlight/nvidia_0/brightness)
BRIGHTNESS_DISPLAY="   ${BRIGHTNESS}%"

TIME=$(date +%H:%M)
TIME_DISPLAY="   ${TIME}"

MUSIC_DISPLAY=$(~/Projects/src/dotfiles/scripts/music.sh)

WEBCAM_DISPLAY=$(~/Projects/src/dotfiles/scripts/webcam.sh)

xsetroot -name "$WEBCAM_DISPLAY   $MUSIC_DISPLAY    $MICROPHONE_DISPLAY    $VOLUME_DISPLAY    $INTERNET_DISPLAY    $BATTERY_DISPLAY    $BRIGHTNESS_DISPLAY    $TIME_DISPLAY   "
