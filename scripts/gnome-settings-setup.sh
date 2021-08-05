#!/bin/bash

# ##############################################################################
# Script for setting up Gnome preferences
# ##############################################################################

gsettings set org.gnome.desktop.wm.preferences button-layout "close:appmenu"; #default: appmenu:close
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' #default: Adwaita
gsettings set org.gnome.mutter dynamic-workspaces false #default: true
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10 #default: 4
gsettings set org.gnome.desktop.interface clock-show-seconds true #default: false
gsettings set org.gnome.desktop.interface clock-show-weekday true #default: false
