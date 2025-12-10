#!/bin/bash

VOL_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

VOLUME=$(echo "$VOL_INFO" | grep -oP 'Volume:\s*\K[0-9.]+')

PERCENT=$(awk "BEGIN {printf \"%d\", $VOLUME * 100}")

if echo "$VOL_INFO" | grep -q "MUTED"; then
    echo "󰖁  $PERCENT%"
    exit 0
fi

if (( PERCENT >= 66 )); then
    ICON="󰕾 "
elif (( PERCENT >= 33 )); then
    ICON="󰖀"
elif (( PERCENT > 0 )); then
    ICON="󰖀"
else
    ICON="󰕿"
fi

echo "$ICON $PERCENT%"
