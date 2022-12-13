#!/bin/bash

# purple
accent_color="#B16286"
#green
#accent_color="#98971A"

# dunst color change
# change highlight color in dunst
sed -i "s/highlight.*/highlight = \"$accent_color\"/" ~/.config/dunst/dunstrc
# change frame color in dunst
sed -i "s/frame.*/frame_color = \"$accent_color\"/" ~/.config/dunst/dunstrc

killall dunst
dunst &

for proc in $(ps aux | grep "subscribe desktop" | awk '{print $2}')
do 
    kill $proc
done

bspc subscribe desktop | ~/.config/bspwm/scripts/desktop-notifier &
 
# rofi color change
# change accent color in rofi
sed -i "0,/accent.*/{s/accent.*/accent:             $accent_color;/}" ~/.config/rofi/themes/gruvbox-green.rasi

# tmux color change
sed -i "s/status-style bg=.*/status-style bg=$accent_color/" ~/.config/tmux/tmux.conf

# xob color change
sed -i "s/bg     =.*/bg     = \"$accent_color\"\;/" ~/.config/xob/styles.cfg
