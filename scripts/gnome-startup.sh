#!/bin/bash

# ##############################################################################
# Script for starting up Gnome "session"
# ##############################################################################

for ((i = 0; i < 10; i++)) do 
  pgrep -f gnome-flashback || /usr/bin/gnome-flashback & #OK
  (("$(pgrep -fc gsd-a11y-settings)" > 1)) || /usr/lib/gsd-a11y-settings &
  (("$(pgrep -fc backlight-helper)" > 1)) || /usr/lib/gsd-backlight-helper &
  (("$(pgrep -fc gsd-color)" > 1)) || /usr/lib/gsd-color &
  (("$(pgrep -fc gsd-datetime)" > 1)) || /usr/lib/gsd-datetime &
  pgrep -f gsd-disk-utility-notify || /usr/lib/gsd-disk-utility-notify & #OK
  (("$(pgrep -fc gsd-housekeeping)" > 1)) || /usr/lib/gsd-housekeeping &
  (("$(pgrep -fc gsd-keyboard)" > 1)) || /usr/lib/gsd-keyboard &
  (("$(pgrep -fc gsd-media-keys)" > 1)) || /usr/lib/gsd-media-keys &
  (("$(pgrep -fc gsd-power)" > 1)) || /usr/lib/gsd-power &
  (("$(pgrep -fc gsd-printer)" > 1)) || /usr/lib/gsd-printer &
  (("$(pgrep -fc gsd-print-notifications)" > 1)) || /usr/lib/gsd-print-notifications &
  (("$(pgrep -fc gsd-rfkill)" > 1)) || /usr/lib/gsd-rfkill &
  (("$(pgrep -fc gsd-screensaver-proxy)" > 1)) || /usr/lib/gsd-screensaver-proxy &
  (("$(pgrep -fc gsd-sharing)" > 1)) || /usr/lib/gsd-sharing &
  (("$(pgrep -fc gsd-smartcard)" > 1)) || /usr/lib/gsd-smartcard &
  (("$(pgrep -fc gsd-sound)" > 1)) || /usr/lib/gsd-sound &
  pgrep -f gsd-usb-protection || /usr/lib/gsd-usb-protection & #OK
  (("$(pgrep -fc gsd-wacom)" > 1)) || /usr/lib/gsd-wacom &
  (("$(pgrep -fc gsd-wacom-oled-helper)" > 1)) || /usr/lib/gsd-wacom-oled-helper &
  pgrep -f gsd-wwan || /usr/lib/gsd-wwan & #OK
  pgrep -f gsd-xsettings || /usr/lib/gsd-xsettings & #OK
  sleep .1
done
