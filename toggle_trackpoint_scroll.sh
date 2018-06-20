#!/bin/bash

device="TPPS/2 IBM TrackPoint"
state=$(xinput list-props "$device" | grep "Evdev Wheel Emulation (" | grep -o "[01]$")

outputState="1"
echo "State $state"
if [[ $state == "1" ]];then
  outputState="0"
  echo "Disable mouse wheel"
else
  echo "Enabling mouse wheel"
fi

xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" $outputState
