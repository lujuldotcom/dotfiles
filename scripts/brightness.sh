#!/bin/bash

CURRENT_INTEL=$(cat /sys/class/backlight/intel_backlight/brightness)
INTEL_MAX=$(cat /sys/class/backlight/intel_backlight/max_brightness)

INTEL_STEP=25
INTEL_MIN=21

if [[ "$1" == "+" ]]; then
    NEW_VALUE_INTEL=$(( CURRENT_INTEL + INTEL_STEP ))
elif [[ "$1" == "-" ]]; then
    NEW_VALUE_INTEL=$(( CURRENT_INTEL - INTEL_STEP ))
else
    exit 0
fi

if [[ $NEW_VALUE_INTEL -gt $INTEL_MAX ]]; then
    NEW_VALUE_INTEL=$INTEL_MAX
elif [[ $NEW_VALUE_INTEL -lt $INTEL_MIN ]]; then
    NEW_VALUE_INTEL=$INTEL_MIN
fi

NEW_VALUE_NVIDIA=$(( (NEW_VALUE_INTEL + 4) / 5 ))

echo "$NEW_VALUE_INTEL" | sudo /usr/bin/tee /sys/class/backlight/intel_backlight/brightness > /dev/null
echo "$NEW_VALUE_NVIDIA" | sudo /usr/bin/tee /sys/class/backlight/nvidia_0/brightness > /dev/null
