#!/bin/bash

MIC_STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)

if echo "$MIC_STATUS" | grep -q "MUTED"; then
    echo "󰍭"
else
    echo "󰍬"
fi
