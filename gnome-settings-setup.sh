#!/bin/bash

# ##############################################################################
# Reset Gnome settings and do initial stuff
# ##############################################################################
gsettings list-schemas | xargs -n 1 gsettings reset-recursively;
mkdir -p ~/.local/share/glib-2.0/schemas;
cp ~/.local/share/gnome-shell/extensions/space-bar@luchrioh/schemas/*.gschema.xml ~/.local/share/glib-2.0/schemas;
cp ~/.local/share/gnome-shell/extensions/AlphabeticalAppGrid@stuarthayhurst/schemas/*.gschema.xml ~/.local/share/glib-2.0/schemas;
cp ~/.local/share/gnome-shell/extensions/pop-shell@system76.com/schemas/*.gschema.xml ~/.local/share/glib-2.0/schemas;
glib-compile-schemas ~/.local/share/glib-2.0/schemas;
xmodmap -e "keycode  26 = e E e E EuroSign EuroSign";

# ##############################################################################
# Gnome settings configurations
# ##############################################################################
gsettings set org.gnome.ControlCenter last-panel 'keyboard';
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'fi+mac')]";
gsettings set org.gnome.shell disabled-extensions "['ding@rastersoft.com', 'ubuntu-dock@ubuntu.com']";
gsettings set org.gnome.shell enabled-extensions "['space-bar@luchrioh', 'AlphabeticalAppGrid@stuarthayhurst', 'pop-shell@system76.com']";
gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'com.vixalien.sticky.desktop',  'slack.desktop', 'code.desktop', 'kitty.desktop','org.keepassxc.KeePassXC.desktop', 'com.mattjakeman.ExtensionManager.desktop', 'gnome-control-center.desktop']";
gsettings set org.gnome.ControlCenter last-panel 'mouse';
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark';
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-purple-dark';
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true;
gsettings set org.gnome.gedit.preferences.editor scheme 'Yaru-dark';
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
gsettings set org.gnome.shell.extensions.space-bar.appearance active-workspace-background-color 'rgb(179,98,255)';
gsettings set org.gnome.shell.extensions.space-bar.appearance active-workspace-text-color 'rgb(22,14,63)';
gsettings set org.gnome.shell.extensions.space-bar.appearance inactive-workspace-text-color 'rgb(179,98,255)';
gsettings set org.gnome.shell.extensions.pop-shell activate-launcher @as [];
gsettings set org.gnome.shell.extensions.pop-shell hint-color-rgba 'rgb(179,98,255)';
gsettings set org.gnome.shell.extensions.pop-shell snap-to-grid true;
gsettings set org.gnome.shell.extensions.pop-shell tile-accept "['Return', 'KP_Enter']";
gsettings set org.gnome.shell.extensions.pop-shell tile-by-default true;
gsettings set org.gnome.shell.extensions.pop-shell tile-enter "['<Super>Space']";
gsettings set org.gnome.shell.extensions.pop-shell tile-orientation "['<Shift><Super><Alt>o']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-floating "['<Shift><Super><Alt>space']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-stacking "['s']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-stacking-global "['<Shift><Super><Alt>s']";
gsettings set org.gnome.shell.extensions.pop-shell toggle-tiling "['<Shift><Super><Alt>t']";
