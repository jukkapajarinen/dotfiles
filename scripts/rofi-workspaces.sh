#!/bin/bash

# ##############################################################################
# Script for handling workspace switching with Rofi
# ##############################################################################

# Specify dmenu options for rofi
options=(
  "Workspace 1"
  "Workspace 2"
  "Workspace 3"
  "Workspace 4"
  "Workspace 5"
  "Workspace 6"
  "Workspace 7"
  "Workspace 8"
  "Workspace 9"
  "Workspace 0"
);
dmenuOptions="${options[*]/#/\\n}";
dmenuOptions="${dmenuOptions/\\n/}";
dmenuOptions="${dmenuOptions// \\n/\\n}";

# Show the rofi and listen to stdin
rofi_action=$(echo -e "${dmenuOptions[@]}" | rofi -i -dmenu -selected-row 0);

# Handle all actions at once
workspaces=("$(bspc query --desktops)");
for idx in "${!options[@]}"; do
  if [[ "${rofi_action}" == "${options[${idx}]}" ]]; then
    bspc desktop -f "${workspaces[${idx}]}";
  fi
done
