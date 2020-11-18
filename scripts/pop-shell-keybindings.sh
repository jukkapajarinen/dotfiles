#!/bin/bash

# ##############################################################################
# Pop!_Shell setup keybindings
# ##############################################################################

dconf write /org/gnome/shell/extensions/pop-shell/activate-launcher "['<Ctrl>space']";
dconf write /org/gnome/shell/extensions/pop-shell/toggle-floating "['<Ctrl><Shift><Alt>Space']";
gsettings set org.gnome.desktop.wm.keybindings close "['<Ctrl>q']";
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Ctrl>h']";
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Ctrl><Shift><Alt>f']";
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Ctrl>Tab']";
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Ctrl>Tab']";
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Ctrl><Shift><Alt>b']";
gsettings set org.gnome.settings-daemon.plugins.media-keys email "['<Ctrl><Shift><Alt>e']";
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Ctrl><Shift><Alt>f']";
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Ctrl><Shift><Alt>Return']";
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Ctrl><Shift><Alt>l']";
gsettings set org.gnome.shell.keybindings toggle-application-view "['XF86LaunchB', '<Ctrl><Shift><Alt>n']";
gsettings set org.gnome.shell.keybindings toggle-overview "['XF86LaunchA', '<Ctrl><Shift><Alt>m']";

# bspc config initial_polarity second_child;
# bspc config top_padding 32;
# bspc config bottom_padding 32;
# bspc config window_gap 8;
# bspc config right_padding 0;
# bspc config left_padding 0;
# bspc config border_width 6;
# bspc config focused_border_color "#69558c";
# bspc config active_border_color "#44475a";
# bspc config normal_border_color "#44475a";
# bspc config pointer_modifier mod5; # Opt_L => mod1, Opt_R => mod5
# bspc config pointer_action1 move;
# bspc config pointer_action2 resize_corner;
# bspc config focus_follows_pointer false;
# bspc config pointer_follows_focus false;

# ctrl + mod5 + shift + Left
#   bspc node -s west
# ctrl + mod5 + shift + Down
#   bspc node -s south
# ctrl + mod5 + shift + Up
#   bspc node -s north
# ctrl + mod5 + shift + Right
#   bspc node -s east

# ctrl + mod5 + shift + 1
#   id=$(bspc query -N -n); bspc node -d 1; bspc node -f ${id}
# ctrl + mod5 + shift + 2
#   id=$(bspc query -N -n); bspc node -d 2; bspc node -f ${id}
# ctrl + mod5 + shift + 3
#   id=$(bspc query -N -n); bspc node -d 3; bspc node -f ${id}
# ctrl + mod5 + shift + 4
#   id=$(bspc query -N -n); bspc node -d 4; bspc node -f ${id}
# ctrl + mod5 + shift + 5
#   id=$(bspc query -N -n); bspc node -d 5; bspc node -f ${id}
# ctrl + mod5 + shift + 6
#   id=$(bspc query -N -n); bspc node -d 6; bspc node -f ${id}
# ctrl + mod5 + shift + 7
#   id=$(bspc query -N -n); bspc node -d 7; bspc node -f ${id}
# ctrl + mod5 + shift + 8
#   id=$(bspc query -N -n); bspc node -d 8; bspc node -f ${id}
# ctrl + mod5 + shift + 9
#   id=$(bspc query -N -n); bspc node -d 9; bspc node -f ${id}
# ctrl + mod5 + shift + 0
#   id=$(bspc query -N -n); bspc node -d 0; bspc node -f ${id}

# ctrl + mod5 + shift + r
#   pkill -USR1 -x sxhkd; bash ~/.config/bspwm/bspwmrc
  
# ctrl + shift + 3
#   gnome-screenshot
# ctrl + shift + 4
#   gnome-screenshot -a

# Print info that execution finished
echo "==> Pop!_Shell and Gnome keybindings finished."