#!/bin/bash

# Displaying power profile
power_profile=$(powerprofilesctl | grep -i \* | cut -d " " -f 2)
if [[ $power_profile == "power-saver:" ]]
then
    power_profile="Power Saver"
else
    power_profile="Performance"
fi

# Picking battery icon based on level
bat=$(acpi b | awk -F ", " '{print $2}' | awk -F "%" '{print $1}')
if [[ bat -gt 80 ]]
then
    bat_icon="full"
elif [[ bat -gt 50 ]]
then
    bat_icon="good"
elif [[ bat -gt 20 ]]
then
    bat_icon="low"
else
    bat_icon="caution"
fi


message=$(acpi b | awk -F ", " '{print $3}')
# If not triggered by plugged in/unplugged, keep message and update icon to show charge state
if [[  "$1" == "" ]]
   then
   status="$(awk -F '=' '/ONLINE/ {print $2}' /sys/class/power_supply/AC/uevent)"
	
   if [[ "$status" == "1" ]]
   then
       bat_icon="$bat_icon-charging"
   fi
# If triggered by udev, don't show battery stats
else
   if [[ "$1" == "disconnected" ]]
      then
      message="disconnected" 
   else
       bat_icon="$bat_icon-charging"
       message="connected" 
   fi

fi

sudo -u jerome DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus DISPLAY=:0 dunstify -r 2 "Battery Level" "$bat%,  $message\nMode: $power_profile\n" -h int:value:$bat -i battery-"$bat_icon"
