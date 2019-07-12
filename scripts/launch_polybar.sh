#!/bin/bash

# Terminate already running bar instances
killall -q polybar;

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar on all monitors
for monitor in $(polybar -m | cut -d":" -f1); do
  export MONITOR=$monitor && polybar --reload topbar &
done

echo "Polybar launced.";