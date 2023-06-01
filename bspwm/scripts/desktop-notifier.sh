#!/bin/bash

bspc subscribe desktop_focus | while read _; do
    desktop_name="$(bspc query -D -d --names)"
    dunstify -r 1 "$desktop_name" -i preferences-desktop-display
done
