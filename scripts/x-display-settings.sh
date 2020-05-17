#!/bin/bash

# ##############################################################################
# Script for resetting X11 display settings
# ##############################################################################

# Read profile from the cli args
profile=$1;

# Home (Retina 13inch and Acer 4K 43inch)
if [[ $profile == "home" ]]; then
  xrandr --output eDP-1 --mode 1920x1200 --left-of HDMI-2;
  xrandr --output HDMI-2 --primary --mode 3840x2160 --right-of eDP-1;

# TODO: Actual auto profile
elif [[ $profile == "auto" ]]; then
  xrandr --output eDP-1 --mode 1920x1200 --left-of HDMI-2;
  xrandr --output HDMI-2 --primary --mode 3840x2160 --right-of eDP-1;

# TODO: Other profiles
elif [[ $profile == "other" ]]; then
  echo "TODO: Other profiles";

# Unknown profile
else
  echo "Error: You did not specify any known profile!";
  exit 1;
fi

# Inform user that the script ended
echo "Display settings finished.";