#!/bin/bash

# ##############################################################################
# Gnome settings configurations
# ##############################################################################

gsettings set org.gnome.desktop.calendar show-weekdate true;
gsettings set org.gnome.desktop.default-applications.terminal exec "kitty";
gsettings set org.gnome.desktop.interface clock-show-seconds true;
gsettings set org.gnome.desktop.interface clock-show-weekday true;
gsettings set org.gnome.desktop.interface clock-show-weekday true;
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark';
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q', '<Super>BackSpace']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Shift><Super><Ctrl><Alt>1']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Shift><Super><Ctrl><Alt>0']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Shift><Super><Ctrl><Alt>2']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Shift><Super><Ctrl><Alt>3']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Shift><Super><Ctrl><Alt>4']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "['<Shift><Super><Ctrl><Alt>5']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 "['<Shift><Super><Ctrl><Alt>6']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 "['<Shift><Super><Ctrl><Alt>7']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 "['<Shift><Super><Ctrl><Alt>8']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 "['<Shift><Super><Ctrl><Alt>9']";
gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "['<Super>']";
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Shift><Super><Alt>d']";
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']";
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']";
gsettings set org.gnome.desktop.wm.keybindings switch-input-source  "[]";
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward  "[]";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super><Ctrl><Alt>1']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super><Ctrl><Alt>0']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super><Ctrl><Alt>2']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super><Ctrl><Alt>3']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super><Ctrl><Alt>4']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super><Ctrl><Alt>5']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super><Ctrl><Alt>6']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super><Ctrl><Alt>7']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Super><Ctrl><Alt>8']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Super><Ctrl><Alt>9']";
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']";
gsettings set org.gnome.desktop.wm.preferences button-layout "close,minimize,maximize:appmenu";
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10;
gsettings set org.gnome.mutter dynamic-workspaces false;
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-kitty/']";
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Shift><Super><Alt>l']";
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-kitty/ binding "<Super>Return";
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-kitty/ command "kitty";
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open-kitty/ name "Open kitty";

# ##############################################################################
# Gnome extensions configurations
# ##############################################################################

gnome-extensions enable pop-shell@system76.com;
gsettings set org.gnome.shell.extensions.pop-shell activate-launcher "[]";
gsettings set org.gnome.shell.extensions.pop-shell active-hint false;
gsettings set org.gnome.shell.extensions.pop-shell column-size 64;
gsettings set org.gnome.shell.extensions.pop-shell focus-down "['<Super>Down', '<Super>KP_Down', '<Super>j']";
gsettings set org.gnome.shell.extensions.pop-shell focus-left "['<Super>Left', '<Super>KP_Left', '<Super>h']";
gsettings set org.gnome.shell.extensions.pop-shell focus-right "['<Super>Right', '<Super>KP_Right', '<Super>l']";
gsettings set org.gnome.shell.extensions.pop-shell focus-up "['<Super>Up', '<Super>KP_Up', '<Super>k']";
gsettings set org.gnome.shell.extensions.pop-shell gap-inner 2;
gsettings set org.gnome.shell.extensions.pop-shell gap-outer 2;
gsettings set org.gnome.shell.extensions.pop-shell hint-color-rgba 'rgba(189,255,0, 1)';
gsettings set org.gnome.shell.extensions.pop-shell log-level 0;
gsettings set org.gnome.shell.extensions.pop-shell management-orientation "['o']";
gsettings set org.gnome.shell.extensions.pop-shell pop-monitor-down "['<Super><Shift><Primary>Down', '<Super><Shift><Primary>KP_Down', '<Super><Shift><Primary>j']";
gsettings set org.gnome.shell.extensions.pop-shell pop-monitor-left "['<Super><Shift>Left', '<Super><Shift>KP_Left', '<Super><Shift>h']";
gsettings set org.gnome.shell.extensions.pop-shell pop-monitor-right "['<Super><Shift>Right', '<Super><Shift>KP_Right', '<Super><Shift>l']";
gsettings set org.gnome.shell.extensions.pop-shell pop-monitor-up "['<Super><Shift><Primary>Up', '<Super><Shift><Primary>KP_Up', '<Super><Shift><Primary>k']";
gsettings set org.gnome.shell.extensions.pop-shell pop-workspace-down "['<Super><Shift>Down', '<Super><Shift>KP_Down', '<Super><Shift>j']";
gsettings set org.gnome.shell.extensions.pop-shell pop-workspace-up "['<Super><Shift>Up', '<Super><Shift>KP_Up', '<Super><Shift>k']";
gsettings set org.gnome.shell.extensions.pop-shell row-size 64;
gsettings set org.gnome.shell.extensions.pop-shell show-skip-taskbar true;
gsettings set org.gnome.shell.extensions.pop-shell show-title true;
gsettings set org.gnome.shell.extensions.pop-shell smart-gaps false;
gsettings set org.gnome.shell.extensions.pop-shell snap-to-grid true;
gsettings set org.gnome.shell.extensions.pop-shell tile-accept "['Return', 'KP_Enter']";
gsettings set org.gnome.shell.extensions.pop-shell tile-by-default true;
gsettings set org.gnome.shell.extensions.pop-shell tile-enter "['<Super>Space']";
gsettings set org.gnome.shell.extensions.pop-shell tile-move-down "['Down', 'KP_Down', 'j']";
gsettings set org.gnome.shell.extensions.pop-shell tile-move-left "['Left', 'KP_Left', 'h']";
gsettings set org.gnome.shell.extensions.pop-shell tile-move-right "['Right', 'KP_Right', 'l']";
gsettings set org.gnome.shell.extensions.pop-shell tile-move-up "['Up', 'KP_Up', 'k']";
gsettings set org.gnome.shell.extensions.pop-shell tile-orientation "['<Shift><Super><Alt>o']";
gsettings set org.gnome.shell.extensions.pop-shell tile-reject "['Escape']";
gsettings set org.gnome.shell.extensions.pop-shell tile-resize-down "['<Shift>Down', '<Shift>KP_Down', '<Shift>j']";
gsettings set org.gnome.shell.extensions.pop-shell tile-resize-left "['<Shift>Left', '<Shift>KP_Left', '<Shift>h']";
gsettings set org.gnome.shell.extensions.pop-shell tile-resize-right "['<Shift>Right', '<Shift>KP_Right', '<Shift>l']";
gsettings set org.gnome.shell.extensions.pop-shell tile-resize-up "['<Shift>Up', '<Shift>KP_Up', '<Shift>k']";
gsettings set org.gnome.shell.extensions.pop-shell tile-swap-down "['<Primary>Down', '<Primary>KP_Down', '<Primary>j']";
gsettings set org.gnome.shell.extensions.pop-shell tile-swap-left "['<Primary>Left', '<Primary>KP_Left', '<Primary>h']";
gsettings set org.gnome.shell.extensions.pop-shell tile-swap-right "['<Primary>Right', '<Primary>KP_Right', '<Primary>l']";
gsettings set org.gnome.shell.extensions.pop-shell tile-swap-up "['<Primary>Up', '<Primary>KP_Up', '<Primary>k']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-floating "['<Shift><Super><Alt>space']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-stacking "['s']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-stacking-global "['<Shift><Super><Alt>s']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-tiling "['<Shift><Super><Alt>t']";
