#!/bin/bash

WAYLAND_DISPLAY=wayland-0
WP_PATH=/home/jerome/.config/sway/wallpapers/chosen
SWAYSOCK=$(find /run/user/1000/sway*sock)

curr=$(cat /home/jerome/.config/wallpapers/current)

contents=$(($(find /home/jerome/.config/wallpapers/chosen | wc -l) - 1))

if [ $curr -eq $contents ]
then
    curr=0
fi

curr=$((10#$curr + 01))

if [ $curr -lt $((10#10)) ]
then
    curr=0$curr
fi

swaymsg output "*" bg /home/jerome/.config/sway/wallpapers/chosen/$curr* fill

echo /home/jerome/.config/sway/wallpapers/chosen/$curr*

echo $curr > /home/jerome/.config/sway/wallpapers/current

exit 0
