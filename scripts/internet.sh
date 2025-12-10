#!/bin/bash

WIFI_INTERFACE="wlp0s20f3"
VPN_INTERFACES=("be" "ca" "ch" "de" "nl" "uk" "us")

for VPN in "${VPN_INTERFACES[@]}"; do
    if ip addr show dev "$VPN" 2>/dev/null | grep -q "inet "; then
        echo "󱚿 "
        exit 0
    fi
done

if ! rfkill list all | grep -q "Soft blocked: no"; then
    echo "󰀝"
    exit 0
fi

ETH_INTERFACE=$(for iface in /sys/class/net/en*; do
    iface=$(basename "$iface")
    if [[ $(cat /sys/class/net/"$iface"/carrier) == "1" ]] && ip addr show "$iface" | grep -q "inet "; then
        echo "$iface"
        break
    fi
done)

if [[ -n "$ETH_INTERFACE" ]]; then
    echo "󰈁"
elif ip addr show "$WIFI_INTERFACE" | grep -q "inet "; then
    echo "󰖩 "
else
    echo "󰖪 "
fi
