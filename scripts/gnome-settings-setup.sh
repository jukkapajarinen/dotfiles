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
gsettings set org.gnome.desktop.default-applications.terminal exec "kitty"

gsettings set org.gnome.shell.extensions.pop-shell gap-inner 4
gsettings set org.gnome.shell.extensions.pop-shell gap-outer 4
gsettings set org.gnome.shell.extensions.pop-shell active-hint false
gsettings set org.gnome.shell.extensions.pop-shell hint-color-rgba 'rgba(255, 121, 198, 1)'
gsettings set org.gnome.shell.extensions.vitals update-time 1
gsettings set org.gnome.shell.extensions.vitals position-in-panel 1 #1=center
gsettings set org.gnome.shell.extensions.vitals use-higher-precision true
gsettings set org.gnome.shell.extensions.vitals show-temperature true
gsettings set org.gnome.shell.extensions.vitals show-processor true
gsettings set org.gnome.shell.extensions.vitals show-memory true
gsettings set org.gnome.shell.extensions.vitals show-storage true
gsettings set org.gnome.shell.extensions.vitals show-battery false
gsettings set org.gnome.shell.extensions.vitals show-network false
gsettings set org.gnome.shell.extensions.vitals show-system false
gsettings set org.gnome.shell.extensions.vitals show-fan false
gsettings set org.gnome.shell.extensions.vitals show-voltage false
gsettings set org.gnome.shell.extensions.arch-update check-interval 30
gsettings set org.gnome.shell.extensions.arch-update position-number 0
gsettings set org.gnome.shell.extensions.arch-update update-cmd "kitty sh -c  'sudo pacman -Syu ; echo Done - Press enter to exit; read _'"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-kitty/ name "Open kitty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-kitty/ command "kitty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-kitty/ binding "<Shift><Super><Alt>Return"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-kitty/']";
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']";
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']";
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']";
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Shift><Super><Alt>f']";
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Shift><Super><Alt>d']";
gsettings set org.gnome.desktop.wm.keybindings switch-input-source  "[]";
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward  "[]";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super><Ctrl><Alt>1']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Super><Ctrl><Alt>2']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Super><Ctrl><Alt>3']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Super><Ctrl><Alt>4']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "['<Super><Ctrl><Alt>5']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 "['<Super><Ctrl><Alt>6']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 "['<Super><Ctrl><Alt>7']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 "['<Super><Ctrl><Alt>8']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 "['<Super><Ctrl><Alt>9']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Ctrl><Alt>10']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Shift><Super><Ctrl><Alt>1']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Shift><Super><Ctrl><Alt>2']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Shift><Super><Ctrl><Alt>3']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Shift><Super><Ctrl><Alt>4']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Shift><Super><Ctrl><Alt>5']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Shift><Super><Ctrl><Alt>6']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Shift><Super><Ctrl><Alt>7']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Shift><Super><Ctrl><Alt>8']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Shift><Super><Ctrl><Alt>9']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Shift><Super><Ctrl><Alt>10']";
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "['<Shift><Super>3']";
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot "['<Shift><Super>4']";
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip "[]";
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip "[]";
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot "[]";
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip "[]";
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Shift><Super><Alt>l']";
gsettings set org.gnome.shell.extensions.pop-shell activate-launcher "['<Super>space']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-floating "['<Shift><Super><Alt>space']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-stacking-global "['<Shift><Super><Alt>s']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-tiling "['<Shift><Super><Alt>t']";
gsettings set org.gnome.shell.extensions.pop-shell tile-orientation "['<Shift><Super><Alt>o']";
