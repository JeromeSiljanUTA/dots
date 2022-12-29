#!/bin/bash

swaymsg "input 1386:887:Wacom_Intuos_BT_S_Pen map_to_region 0 0 1920 1080"

swaymsg "input 1386:887:Wacom_Intuos_BT_S_Pen map_to_region $(slurp | sed 's/[,,x]/ /g')"
