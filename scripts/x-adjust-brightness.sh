#!/bin/bash

# ##############################################################################
# Script for adjusting X11 display brightness
# ##############################################################################

# Declare variables
availableDisplays=$(xrandr | grep -w connected  | awk '{print $1}');
primaryBrightness=$(xrandr --verbose | grep "connected primary" -A5 | tail -n1 | awk '{print $2}');
display=$1;
direction=$2;

if ! { [[ $display == "all" ]] || [[ $(xrandr | grep -w connected | grep $display) ]]; }; then
  echo -e "Error: Your display was invalid! \nUsage: ./adjust-brightness.sh [display|all] [up|down|reset]";
  exit 1;
fi

if ! { [[ $direction == "up" ]] || [[ $direction == "down" ]] || [[ $direction == "reset" ]]; }; then
  echo -e "Error: Your direction was invalid! \nUsage: ./adjust-brightness.sh [display|all] [up|down|reset]";
  exit 1;
fi

# Convert up and down to + and -
[[ $direction == "up" ]] && direction="+";
[[ $direction == "down" ]] && direction="-";

# Increase or decrease brightness for all displays
if [[ $display == "all" ]]; then
  nextBrightness=$(awk "BEGIN {printf \"%.1f\",${primaryBrightness}${direction}0.1}");
  [[ $direction == "reset" ]] && nextBrightness="1.0";
  [[ $nextBrightness == "1.6" ]] && nextBrightness="1.5";
  [[ $nextBrightness == "0.0" ]] && nextBrightness="0.1";
  for display in $availableDisplays
  do xrandr --output $display --brightness $nextBrightness; done

# Increase or decrease brightness for requested display
else
  currentBrightness=$(xrandr --verbose | grep "$display connected" -A5 | tail -n1 | awk '{print $2}');
  nextBrightness=$(awk "BEGIN {printf \"%.1f\",${currentBrightness}${direction}0.1}");
  [[ $direction == "reset" ]] && nextBrightness="1.0";
  [[ $nextBrightness == "1.6" ]] && nextBrightness="1.5";
  [[ $nextBrightness == "0.0" ]] && nextBrightness="0.1";
  xrandr --output $display --brightness $nextBrightness;
fi

# Inform user that the script ended
echo "Brightness adjustments finished." && exit 0;