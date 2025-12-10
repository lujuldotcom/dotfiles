#!/bin/bash

status=$(mpc status)

if echo "$status" | grep -q '\[paused\]'; then
    echo "󰏤"
elif echo "$status" | grep -q '\[playing\]'; then
    if mpc | grep -q 'random: on'; then
        echo " "
    else
        echo "󰝚 "
    fi
else
    echo "󰝛 "
fi
