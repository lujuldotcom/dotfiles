#!/bin/bash

POWER_PATH="/sys/class/power_supply"

BATTERY_PERCENT=$(cat "$POWER_PATH/BAT0/capacity")
STATUS="$POWER_PATH/ADP1/online"

if grep -q 1 "$STATUS"; then
    case $BATTERY_PERCENT in
        100) ICON="󰂅 " ;;
        9[0-9]) ICON="󰂋 " ;;
        8[0-9]) ICON="󰂊 " ;;
        7[0-9]) ICON="󰢞 " ;;
        6[0-9]) ICON="󰂉 " ;;
        5[0-9]) ICON="󰢝 " ;;
        4[0-9]) ICON="󰂈 " ;;
        3[0-9]) ICON="󰂇 " ;;
        2[0-9]) ICON="󰂆 " ;;
        1[0-9]) ICON="󰢜 " ;;
        *) ICON="󰢟 " ;;
    esac
else
    case $BATTERY_PERCENT in
        100) ICON="󰁹" ;;
        9[0-9]) ICON="󰂂" ;;
        8[0-9]) ICON="󰂁" ;;
        7[0-9]) ICON="󰂀" ;;
        6[0-9]) ICON="󰁿" ;;
        5[0-9]) ICON="󰁾" ;;
        4[0-9]) ICON="󰁽" ;;
        3[0-9]) ICON="󰁼" ;;
        2[0-9]) ICON="󰁻" ;;
        1[0-9]) ICON="󰁺" ;;
        *) ICON="󰂎" ;;
    esac
fi

echo "$ICON $BATTERY_PERCENT%"
