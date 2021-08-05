#!/bin/bash

# ##############################################################################
# Script for setting up Gnome preferences
# ##############################################################################

gsettings set org.gnome.desktop.wm.preferences button-layout "close:appmenu";
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true

# ##############################################################################
# Gnome extension preferences
# ##############################################################################

gsettings set org.gnome.shell.extensions.pop-shell gap-inner 4
gsettings set org.gnome.shell.extensions.pop-shell gap-outer 4
gsettings set org.gnome.shell.extensions.pop-shell active-hint false
gsettings set org.gnome.shell.extensions.pop-shell hint-color-rgba 'rgba(255, 255, 255, 1)'

# ##############################################################################
# Keybindings (Gnome and extensions)
# ##############################################################################

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-kitty/ name "Open kitty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-kitty/ command "kitty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-kitty/ binding "<Shift><Super><Alt>Return"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-kitty/']";
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']";
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']";
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']";
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Shift><Super><Alt>f']";
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Shift><Super><Alt>d']";
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "['<Shift><Super>3']";
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot "['<Shift><Super>4']";
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip "[]";
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip "[]";
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot "[]";
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip "[]";
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Shift><Super><Alt>l']";
gsettings set org.gnome.desktop.wm.keybindings switch-input-source  "[]";
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward  "[]";
gsettings set org.gnome.shell.extensions.pop-shell activate-launcher "['<Super>space']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-floating "['<Shift><Super><Alt>space']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-stacking-global "['<Shift><Super><Alt>s']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-tiling "['<Shift><Super><Alt>t']";
gsettings set org.gnome.shell.extensions.pop-shell tile-orientation "['<Shift><Super><Alt>o']";
 
# Print info that execution finished
echo "==> Gnome and Pop!_Shell setup and keybindings finished." 