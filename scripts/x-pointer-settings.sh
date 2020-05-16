#!/bin/bash

# Read all possible available inputs
allPossibleIds=$(xinput list --id-only);

# Loop through possible ids and set settings (or fail silently)
for deviceId in $allPossibleIds; do
  # Try to set natural scrolling
  xinput set-prop $deviceId "libinput Natural Scrolling Enabled" 1 &>/dev/null;

  # Try to set horizontal scrolling
  xinput set-prop $deviceId "libinput Horizontal Scroll Enabled" 1 &>/dev/null;
done

# Inform user that the script ended
echo "Pointer settings finished.";