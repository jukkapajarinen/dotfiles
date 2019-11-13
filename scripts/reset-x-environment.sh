#!/bin/bash

# Reset all currently attached keyboards
$HOME/dotfiles/scripts/keyboard-settings.sh;

# Reset all currently attached mice
$HOME/dotfiles/scripts/pointer-settings.sh;

# Reset all currently added displays
$HOME/dotfiles/scripts/display-settings.sh auto;

# Inform user that the script ended
echo "X-environment resetting finished.";