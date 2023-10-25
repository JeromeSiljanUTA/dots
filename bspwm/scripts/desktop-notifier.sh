#!/bin/bash

bspc subscribe desktop_focus | while read _; do
    desktop_name="$(bspc query -D -d --names)"
    if [[ "$desktop_name" == "Terminal" ]]
    then
	dunstify -r 1 "$desktop_name" -i terminal-symbolic
    elif [[ "$desktop_name" == "Notes" ]]
    then
	dunstify -r 1 "$desktop_name" -i notes-symbolic
    elif [[ "$desktop_name" == "Emacs" ]]
    then
	dunstify -r 1 "$desktop_name" -i emacs-symbolic
    elif [[ "$desktop_name" == "Firefox" ]]
    then
	dunstify -r 1 "$desktop_name" -i firefox-symbolic
    elif [[ "$desktop_name" == "Comms" ]]
    then
	dunstify -r 1 "$desktop_name" -i messengerfordesktop-symbolic
    elif [[ "$desktop_name" == "IDE" ]]
    then
	dunstify -r 1 "$desktop_name" -i programming-symbolic
    elif [[ "$desktop_name" == "Files" ]]
    then
	dunstify -r 1 "$desktop_name" -i file-manager-symbolic
    elif [[ "$desktop_name" == "Media" ]]
    then
	dunstify -r 1 "$desktop_name" -i library-music-symbolic
    else
	dunstify -r 1 "$desktop_name" -i preferences-desktop-display
    fi
done
