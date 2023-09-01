#!/bin/bash

# ##############################################################################
# Script for resetting X11 display settings
# ##############################################################################

# Setup monitors based on hdmi connected
hdmiConnected=$(xrandr -q | grep "HDMI-2 connected" &> /dev/null; echo $?);
if [[ "$hdmiConnected" == "0" ]]; then
  xrandr --output eDP-1 --mode 1920x1200 --left-of HDMI-2;
  xrandr --output HDMI-2 --primary --mode 3840x2160 --right-of eDP-1;
else
  xrandr --output eDP-1 --primary --mode 1920x1200;
fi

# Inform user that the script ended
echo "Display settings finished.";