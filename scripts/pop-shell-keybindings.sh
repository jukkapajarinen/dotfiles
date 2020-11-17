#!/bin/bash

# ##############################################################################
# Pop!_Shell setup keybindings
# ##############################################################################

dconf write /org/gnome/shell/extensions/pop-shell/activate-launcher "['<Ctrl>space']";
gsettings set org.gnome.desktop.wm.keybindings close "['<Ctrl>q']";
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Ctrl>Tab']";
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Ctrl>Tab']";

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

# ctrl + mod5 + shift + Return
#   kitty

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

# ctrl + mod5 + shift + f
#   bspc node -t ~fullscreen
# ctrl + mod5 + shift + space
#   bspc node -t ~floating
# ctrl + mod5 + shift + r
#   pkill -USR1 -x sxhkd; bash ~/.config/bspwm/bspwmrc
# ctrl + mod5 + shift + l
#   bash ~/Scripts/rofi-shutdown.sh
  
# ctrl + q
#   bspc node -c
# ctrl + Tab
#   rofi -show window -show-icons
# ctrl + space
#   rofi -show combi -combi-modi drun,run -show-icons
# ctrl + shift + 3
#   gnome-screenshot
# ctrl + shift + 4
#   gnome-screenshot -a
# XF86LaunchA
#   bash ~/Scripts/rofi-workspaces.sh
# XF86LaunchB
#   rofi -show combi -combi-modi drun,run -show-icons

# Print info that execution finished
echo "==> Pop!_Shell and Gnome keybindings finished."