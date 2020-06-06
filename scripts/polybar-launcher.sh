#!/bin/bash

# ##############################################################################
# Polybar multi monitors script
# ##############################################################################

# Terminate already running bar instances
killall -q polybar;

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Set the primary monitor and add it first
primary=$(xrandr -q | grep 'primary' | awk '{ print$1 }');
export MONITOR=$primary && polybar --reload topbar &

# Launch polybar on all other monitors
for monitor in $(polybar -m | cut -d":" -f1); do
  [[ "$monitor" != "$primary" ]] && export MONITOR=$monitor && polybar --reload topbar &
done

# Inform user that the script ended
echo "Polybar launching finished.";