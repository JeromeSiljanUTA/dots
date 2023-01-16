#!/bin/bash

status="$(awk -F '=' '/ONLINE/ {print $2}' /sys/class/power_supply/AC/uevent)"

if [[ "$status" == "0" ]]
then 
    status="disconnected"
else
    status="connected"
fi

sudo -u jerome DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus DISPLAY=:0 dunstify "Power Supply $status"
