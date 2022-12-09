#!/bin/bash

sinks="$(pactl list sinks | awk -F "#" '/Sink/ {print $2}')"

for sink in $sinks
do 
    echo pactl set-sink-mute $sink toggle
    pactl set-sink-mute $sink toggle
done
