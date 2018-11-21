#!/bin/bash

device="TPPS/2 Elan TrackPoint"
prop="libinput Scroll Method Enabled"
state=$(xinput list-props "$device" | grep "$prop (" | grep -o "[01]$")

outputState="1"
echo "Current state $state"
result="No result"
if [[ $state == "1" ]];then
  outputState="0"
  result="Disable mouse wheel"
else
  result="Enabling mouse wheel"
fi

notify-send --urgency=low -i 0 "$result"
xinput set-prop "$device" "$prop" 0 0 $outputState
