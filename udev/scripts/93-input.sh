#!/bin/bash

if [[ "$2" != "" ]]
then
    sudo -u jerome DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus DISPLAY=:0 dunstify -r 4 "$1 $2"
fi

if [[ "$1" == "Wacom Intuos BT S Pad" ]]
then
    sudo -u jerome DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus DISPLAY=:0 /home/jerome/.config/bspwm/scripts/wacom.sh
