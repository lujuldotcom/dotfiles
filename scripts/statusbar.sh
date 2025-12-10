#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BATTERY_DISPLAY=$("$SCRIPT_DIR/battery.sh")

INTERNET_DISPLAY=$("$SCRIPT_DIR/internet.sh")

MICROPHONE_DISPLAY=$("$SCRIPT_DIR/microphone.sh")
VOLUME_DISPLAY=$("$SCRIPT_DIR/volume.sh")

BRIGHTNESS=$(cat /sys/class/backlight/nvidia_0/brightness)
BRIGHTNESS_DISPLAY="   ${BRIGHTNESS}%"

TIME=$(date +%H:%M)
TIME_DISPLAY="   ${TIME}"

MUSIC_DISPLAY=$("$SCRIPT_DIR/music.sh")

WEBCAM_DISPLAY=$("$SCRIPT_DIR/webcam.sh")

xsetroot -name "$WEBCAM_DISPLAY   $MUSIC_DISPLAY    $MICROPHONE_DISPLAY    $VOLUME_DISPLAY    $INTERNET_DISPLAY    $BATTERY_DISPLAY    $BRIGHTNESS_DISPLAY    $TIME_DISPLAY   "
