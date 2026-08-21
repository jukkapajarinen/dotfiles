#!/bin/bash

# ##############################################################################
# Reset Gnome settings and do initial stuff
# ##############################################################################
gsettings list-schemas | xargs -n 1 gsettings reset-recursively;
mkdir -p ~/.local/share/glib-2.0/schemas;
glib-compile-schemas ~/.local/share/glib-2.0/schemas;

# ##############################################################################
# Gnome configurations
# ##############################################################################
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'fi+mac')]";
gsettings set org.gnome.shell disabled-extensions "['ubuntu-dock@ubuntu.com']";
gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'kitty.desktop', 'code.desktop', 'org.keepassxc.KeePassXC.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Settings.desktop']";
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark';
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-blue-dark';
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-blue-dark';
gsettings set org.gnome.desktop.interface accent-color 'blue';
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll true;
gsettings set org.gnome.desktop.calendar show-weekdate true;
gsettings set org.gnome.desktop.default-applications.terminal exec "kitty";
gsettings set org.gnome.desktop.interface clock-show-seconds true;
gsettings set org.gnome.desktop.interface clock-show-weekday true;
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4;
gsettings set org.gnome.mutter dynamic-workspaces false;
gsettings set org.gnome.mutter workspaces-only-on-primary false;

# ##############################################################################
# Gnome keybindings
# ##############################################################################
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']";
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Super>l']";
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Super>Return";
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "/usr/bin/kitty";
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Kitty terminal";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Shift><Super>1']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Shift><Super>2']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Shift><Super>3']";
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Shift><Super>4']";
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']";
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']";
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']";
