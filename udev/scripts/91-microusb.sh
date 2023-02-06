#!/bin/bash

sudo -u jerome DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus DISPLAY=:0 dunstify -r 4 "MicroSD Card $1"

if [[ "$1" == "added" ]]
then
    udisksctl mount -b /dev/mmcblk0p1
fi
