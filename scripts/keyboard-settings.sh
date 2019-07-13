#!/bin/bash

# Set customized xkb-keymap for all connected keyboards
xkbcomp ~/.xkbmap $DISPLAY;

# Inform user that the script ended
echo "Keyboard settings finished.";