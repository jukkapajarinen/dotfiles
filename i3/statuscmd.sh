#!/bin/bash

# Print the json header for i3bar
echo '{"version":1}'
echo '['
echo '[],'

# Run json-formatted conky
exec conky -c ~/.conkyrc