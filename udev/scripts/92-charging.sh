#!/bin/bash

status="$(awk -F '=' '/ONLINE/ {print $2}' /sys/class/power_supply/AC/uevent)"

if [[ "$status" == "0" ]]
then
    # powerprofilesctl set power-saver
    powerprofilesctl set balanced
    status="disconnected"
else
    powerprofilesctl set performance
    status="connected"
fi

#sudo -u jerome DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus DISPLAY=:0 /home/jerome/.config/bspwm/scripts/notif-battery.sh $status

sudo -u jerome "/home/jerome/.config/bspwm/scripts/notif-battery.sh"
