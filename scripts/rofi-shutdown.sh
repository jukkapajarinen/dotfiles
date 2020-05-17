#!/bin/bash

# Specify dmenu options for rofi
options="Shutdown\nReboot\nLock Screen\nLogout\nSuspend\nHibernate";

# Show the rofi and listen to stdin
rofi_action=$(echo -e "$options" | rofi -i -dmenu -selected-row 2);

# Handle Shutdown action
if [[ $rofi_action == "Shutdown" ]]; then
  systemctl poweroff;

# Handle Reboot action
elif [[ $rofi_action == "Reboot" ]]; then
  systemctl reboot;

# Handle Lock Screen action
elif [[ $rofi_action == "Lock Screen" ]]; then
  xscreensaver-command -lock;

# Handle Logout action
elif [[ $rofi_action == "Logout" ]]; then
  bspc quit; #i3-msg exit;

# Handle Suspend action
elif [[ $rofi_action == "Suspend" ]]; then
  systemctl suspend;

# Handle Hibernate action
elif [[ $rofi_action == "Hibernate" ]]; then
  systemctl hibernate;
fi

# Inform user that the script ended
echo "Selected option: $rofi_action. Script completed.";
