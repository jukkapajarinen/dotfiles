#!/bin/bash

# ##############################################################################
# Script for starting up Gnome "session"
# ##############################################################################

pgrep -f gnome-flashback || gnome-flashback &
pgrep -f gsd-a11y-settings || /usr/lib/gsd-a11y-settings &
pgrep -f gsd-backlight-helper || /usr/lib/gsd-backlight-helper &
pgrep -f gsd-color || /usr/lib/gsd-color &
pgrep -f gsd-datetime || /usr/lib/gsd-datetime &
pgrep -f gsd-disk-utility-notify || /usr/lib/gsd-disk-utility-notify &
pgrep -f gsd-housekeeping || /usr/lib/gsd-housekeeping &
pgrep -f gsd-keyboard || /usr/lib/gsd-keyboard &
pgrep -f gsd-media-keys || /usr/lib/gsd-media-keys &
pgrep -f gsd-power || /usr/lib/gsd-power &
pgrep -f gsd-printer || /usr/lib/gsd-printer &
pgrep -f gsd-print-notifications || /usr/lib/gsd-print-notifications &
pgrep -f gsd-rfkill || /usr/lib/gsd-rfkill &
pgrep -f gsd-screensaver-proxy || /usr/lib/gsd-screensaver-proxy &
pgrep -f gsd-sharing || /usr/lib/gsd-sharing &
pgrep -f gsd-smartcard || /usr/lib/gsd-smartcard &
pgrep -f gsd-sound || /usr/lib/gsd-sound &
pgrep -f gsd-usb-protection || /usr/lib/gsd-usb-protection &
pgrep -f gsd-wacom || /usr/lib/gsd-wacom &
pgrep -f gsd-wacom-oled-helper || /usr/lib/gsd-wacom-oled-helper &
pgrep -f gsd-wwan || /usr/lib/gsd-wwan &
pgrep -f gsd-xsettings || /usr/lib/gsd-xsettings &
