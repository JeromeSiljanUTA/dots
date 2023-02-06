#!/bin/bash

bat=$(acpi b | awk -F ", " '{print $2}' | awk -F "%" '{print $1}')
message=$(acpi b | awk -F ", " '{print $3}')

dunstify -r 2 "Battery Level" "$bat%,  $message" -h int:value:$bat
