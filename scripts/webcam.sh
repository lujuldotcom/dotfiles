#!/bin/bash

if ls /dev/video* 2>/dev/null | grep -q '/dev/video'; then
    echo "   󰖠 "
else
    echo ""
fi
