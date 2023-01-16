#!/bin/bash

if [[ "$2" != "" ]]
then
    sudo -u jerome DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus DISPLAY=:0 dunstify "$1 $2"
fi
