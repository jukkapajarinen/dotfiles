# ##############################################################################
# i3 variable configurations
# ##############################################################################

set $Color_Accent #dc322f
set $Color_Foreground #eee8d5
set $Color_Background #002b36
set $Ctrl Mod4
set $Cmd Control
set $Opt Mod1
set $Opt2 Mod5

# ##############################################################################
# i3 setup configurations
# ##############################################################################

workspace_layout default
default_orientation auto
floating_modifier $Opt
focus_follows_mouse no
for_window [class=".*"] border pixel 0
gaps inner 8
bar {
  i3bar_command i3bar
  status_command ~/dotfiles/scripts/i3-statuscmd.sh
  output primary
  output eDP-1
  output HDMI-2
  output HDMI-1
  output DP-1
  output DP-2
  tray_output primary
  tray_padding 8
  workspace_buttons yes
  strip_workspace_numbers no
  strip_workspace_name yes
  font pango:Fira Code 10
  separator_symbol " "
  position top
  height 32
  colors {
    background $Color_Background
    statusline $Color_Accent
    separator $Color_Accent
    focused_workspace $Color_Accent $Color_Accent $Color_Foreground
    active_workspace $Color_Accent $Color_Accent $Color_Foreground
    inactive_workspace $Color_Background $Color_Background $Color_Foreground
    urgent_workspace $Color_Background $Color_Background $Color_Foreground
    binding_mode $Color_Background $Color_Background $Color_Foreground
  }
}

# ##############################################################################
# i3 keybindings
# ##############################################################################

bindsym $Cmd+$Opt+Shift+Left move left
bindsym $Cmd+$Opt+Shift+Down move down
bindsym $Cmd+$Opt+Shift+Up move up
bindsym $Cmd+$Opt+Shift+Right move right

bindsym $Cmd+$Opt+Shift+1 move container to workspace 1; workspace 1
bindsym $Cmd+$Opt+Shift+2 move container to workspace 2; workspace 2
bindsym $Cmd+$Opt+Shift+3 move container to workspace 3; workspace 3
bindsym $Cmd+$Opt+Shift+4 move container to workspace 4; workspace 4
bindsym $Cmd+$Opt+Shift+5 move container to workspace 5; workspace 5
bindsym $Cmd+$Opt+Shift+6 move container to workspace 6; workspace 6
bindsym $Cmd+$Opt+Shift+7 move container to workspace 7; workspace 7
bindsym $Cmd+$Opt+Shift+8 move container to workspace 8; workspace 8
bindsym $Cmd+$Opt+Shift+9 move container to workspace 9; workspace 9
bindsym $Cmd+$Opt+Shift+0 move container to workspace 10; workspace 10

bindsym $Cmd+$Opt+Shift+f fullscreen toggle
bindsym $Cmd+$Opt+Shift+space floating toggle
bindsym $Cmd+$Opt+Shift+t split toggle
bindsym $Cmd+$Opt+Shift+r "bash ~/.Xsession --reset; i3-msg restart"
bindsym $Cmd+$Opt+Shift+l exec "~/dotfiles/scripts/rofi-shutdown.sh"
bindsym $Cmd+$Opt+Shift+Return exec "kitty"

# ##############################################################################
# i3 MacOS style keybindings
# ##############################################################################

bindsym $Cmd+q kill
bindsym $Cmd+Tab exec "rofi -modi window -show-icons -show window"
bindsym $Cmd+space exec "rofi -modi run -show run"
bindsym $Cmd+Shift+3 exec "scrot -e 'mv $f ~/Desktop/' && notify-send 'Screenshot saved to: ~/Desktop/'"
bindsym $Cmd+Shift+4 exec "scrot -e 'mv $f ~/Desktop/' && notify-send 'Screenshot saved to: ~/Desktop/'"
bindsym XF86MonBrightnessDown exec "~/dotfiles/scripts/x-adjust-brightness.sh all down"
bindsym XF86MonBrightnessUp exec "~/dotfiles/scripts/x-adjust-brightness.sh all up"
bindsym XF86LaunchA exec "notify-send 'XF86LaunchA'"
bindsym XF86LaunchB exec "rofi -modi run -show run"
bindsym XF86KbdBrightnessDown exec "notify-send 'XF86KbdBrightnessDown'"
bindsym XF86KbdBrightnessUp exec "notify-send 'XF86KbdBrightnessUp'"
bindsym XF86AudioPrev exec "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"
bindsym XF86AudioPlay exec "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
bindsym XF86AudioNext exec "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"
bindsym XF86AudioMute exec "pulsemixer --id 0 --toggle-mute"
bindsym XF86AudioLowerVolume exec "pulsemixer --id 0 --change-volume -1"
bindsym XF86AudioRaiseVolume exec "pulsemixer --id 0 --change-volume +1"
bindsym XF86Eject exec "notify-send 'XF86Eject'"
