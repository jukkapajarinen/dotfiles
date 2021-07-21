#!/bin/bash

# ##############################################################################
# Script for setting up Gnome preferences
# ##############################################################################

gsettings set org.gnome.gnome-flashback desktop false; #default: true
gsettings set org.gnome.gnome-flashback root-background true; #default: false
gsettings set org.gnome.desktop.wm.preferences button-layout "close:appmenu"; #default: appmenu:close
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' #default: Adwaita
gsettings set org.gnome.mutter dynamic-workspaces false #default: true
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10 #default: 4
gsettings set org.gnome.desktop.interface clock-show-seconds true #default: false
gsettings set org.gnome.desktop.interface clock-show-weekday true #default: false

# ##############################################################################
# Unset default gnome keybindings
# ##############################################################################

gsettings set org.gnome.desktop.wm.keybindings switch-group []; #default ['<Super>Above_Tab', '<Alt>Above_Tab']
gsettings set org.gnome.desktop.wm.keybindings begin-resize []; #default ['<Alt>F8']
gsettings set org.gnome.desktop.wm.keybindings begin-move []; #default ['<Alt>F7']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right []; #default ['<Super><Shift>Page_Down', '<Super><Shift><Alt>Right', '<Control><Shift><Alt>Right']
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized []; #default ['<Alt>F10']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left []; #default ['<Super><Shift>Page_Up', '<Super><Shift><Alt>Left', '<Control><Shift><Alt>Left']
gsettings set org.gnome.desktop.wm.keybindings cycle-panels []; #default ['<Control><Alt>Escape']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down []; #default ['<Control><Shift><Alt>Down']
gsettings set org.gnome.desktop.wm.keybindings switch-panels []; #default ['<Control><Alt>Tab']
gsettings set org.gnome.desktop.wm.keybindings minimize []; #default ['<Super>h']
gsettings set org.gnome.desktop.wm.keybindings cycle-windows []; #default ['<Alt>Escape']
gsettings set org.gnome.desktop.wm.keybindings switch-input-source []; #default ['<Super>space', 'XF86Keyboard']
gsettings set org.gnome.desktop.wm.keybindings activate-window-menu []; #default ['<Alt>space']
gsettings set org.gnome.desktop.wm.keybindings maximize []; #default ['<Super>Up']
gsettings set org.gnome.desktop.wm.keybindings panel-main-menu []; #default ['<Alt>F1']
gsettings set org.gnome.desktop.wm.keybindings close []; #default ['<Alt>F4']
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-up []; #default ['<Super><Shift>Up']
gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward []; #default ['<Shift><Alt>Escape']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 []; #default ['<Super>Home']
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right []; #default ['<Super><Shift>Right']
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog []; #default ['<Alt>F2']
gsettings set org.gnome.desktop.wm.keybindings switch-panels-backward []; #default ['<Shift><Control><Alt>Tab']
gsettings set org.gnome.desktop.wm.keybindings unmaximize []; #default ['<Super>Down', '<Alt>F5']
gsettings set org.gnome.desktop.wm.keybindings switch-applications []; #default ['<Super>Tab', '<Alt>Tab']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last []; #default ['<Super>End']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 []; #default ['<Super><Shift>Home']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up []; #default ['<Control><Alt>Up']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left []; #default ['<Super>Page_Up', '<Super><Alt>Left', '<Control><Alt>Left']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right []; #default ['<Super>Page_Down', '<Super><Alt>Right', '<Control><Alt>Right']
gsettings set org.gnome.desktop.wm.keybindings cycle-group-backward []; #default ['<Shift><Alt>F6']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down []; #default ['<Control><Alt>Down']
gsettings set org.gnome.desktop.wm.keybindings cycle-panels-backward []; #default ['<Shift><Control><Alt>Escape']
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left []; #default ['<Super><Shift>Left']
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward []; #default ['<Shift><Super>Tab', '<Shift><Alt>Tab']
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward []; #default ['<Shift><Super>space', '<Shift>XF86Keyboard']
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-down []; #default ['<Super><Shift>Down']
gsettings set org.gnome.desktop.wm.keybindings cycle-group []; #default ['<Alt>F6']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up []; #default ['<Control><Shift><Alt>Up']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last []; #default ['<Super><Shift>End']
gsettings set org.gnome.desktop.wm.keybindings switch-group-backward []; #default ['<Shift><Super>Above_Tab', '<Shift><Alt>Above_Tab']

gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-4 []; #default ['<Primary><Alt>F4']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-10 []; #default ['<Primary><Alt>F10']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-3 []; #default ['<Primary><Alt>F3']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-9 []; #default ['<Primary><Alt>F9']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-2 []; #default ['<Primary><Alt>F2']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-8 []; #default ['<Primary><Alt>F8']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-1 []; #default ['<Primary><Alt>F1']
gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts []; #default ['<Super>Escape']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-7 []; #default ['<Primary><Alt>F7']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-12 []; #default ['<Primary><Alt>F12']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-6 []; #default ['<Primary><Alt>F6']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-11 []; #default ['<Primary><Alt>F11']
gsettings set org.gnome.mutter.wayland.keybindings switch-to-session-5 []; #default ['<Primary><Alt>F5']

gsettings set org.gnome.shell.keybindings switch-to-application-4 []; #default ['<Super>4']
gsettings set org.gnome.shell.keybindings switch-to-application-7 []; #default ['<Super>7']
gsettings set org.gnome.shell.keybindings toggle-message-tray []; #default ['<Super>v', '<Super>m']
gsettings set org.gnome.shell.keybindings toggle-application-view []; #default ['<Super>a']
gsettings set org.gnome.shell.keybindings focus-active-notification []; #default ['<Super>n']
gsettings set org.gnome.shell.keybindings switch-to-application-2 []; #default ['<Super>2']
gsettings set org.gnome.shell.keybindings switch-to-application-5 []; #default ['<Super>5']
gsettings set org.gnome.shell.keybindings switch-to-application-8 []; #default ['<Super>8']
gsettings set org.gnome.shell.keybindings open-application-menu []; #default ['<Super>F10']
gsettings set org.gnome.shell.keybindings toggle-overview []; #default ['<Super>s']
gsettings set org.gnome.shell.keybindings switch-to-application-3 []; #default ['<Super>3']
gsettings set org.gnome.shell.keybindings switch-to-application-6 []; #default ['<Super>6']
gsettings set org.gnome.shell.keybindings switch-to-application-9 []; #default ['<Super>9']
gsettings set org.gnome.shell.keybindings shift-overview-up []; #default ['<Super><Alt>Up']
gsettings set org.gnome.shell.keybindings switch-to-application-1 []; #default ['<Super>1']
gsettings set org.gnome.shell.keybindings shift-overview-down []; #default ['<Super><Alt>Down']

gsettings set org.gnome.metacity.keybindings toggle-tiled-left []; #default ['<Super>Left']
gsettings set org.gnome.metacity.keybindings toggle-tiled-right []; #default ['<Super>Right']

gsettings set org.gnome.mutter.keybindings toggle-tiled-right []; #default ['<Super>Right']
gsettings set org.gnome.mutter.keybindings toggle-tiled-left []; #default ['<Super>Left']
gsettings set org.gnome.mutter.keybindings rotate-monitor []; #default ['XF86RotateWindows']
gsettings set org.gnome.mutter.keybindings switch-monitor []; #default ['<Super>p', 'XF86Display']

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings @as [] #default []
gsettings set org.gnome.settings-daemon.plugins.media-keys stop-static [] #default ['XF86AudioStop']
gsettings set org.gnome.settings-daemon.plugins.media-keys eject-static [] #default ['XF86Eject']
gsettings set org.gnome.settings-daemon.plugins.media-keys rotate-video-lock-static [] #default ['<Super>o', 'XF86RotationLockToggle']
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip [] #default ['<Ctrl><Alt>Print']
gsettings set org.gnome.settings-daemon.plugins.media-keys battery-status-static [] #default ['XF86Battery']
gsettings set org.gnome.settings-daemon.plugins.media-keys touchpad-toggle-static [] #default ['XF86TouchpadToggle', '<Ctrl><Super>XF86TouchpadToggle']
gsettings set org.gnome.settings-daemon.plugins.media-keys screen-brightness-up-static [] #default ['XF86MonBrightnessUp']
gsettings set org.gnome.settings-daemon.plugins.media-keys play-static [] #default ['XF86AudioPlay', '<Ctrl>XF86AudioPlay']
gsettings set org.gnome.settings-daemon.plugins.media-keys search-static [] #default ['XF86Search']
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier-zoom-in [] #default ['<Alt><Super>equal']
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip [] #default ['<Ctrl><Shift>Print']
gsettings set org.gnome.settings-daemon.plugins.media-keys rfkill-static [] #default ['XF86WLAN', 'XF86UWB', 'XF86RFKill']
gsettings set org.gnome.settings-daemon.plugins.media-keys pause-static [] #default ['XF86AudioPause']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute-static [] #default ['XF86AudioMute']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up-static [] #default ['XF86AudioRaiseVolume', '<Ctrl>XF86AudioRaiseVolume']
gsettings set org.gnome.settings-daemon.plugins.media-keys calculator-static [] #default ['XF86Calculator']
gsettings set org.gnome.settings-daemon.plugins.media-keys home-static [] #default ['XF86Explorer']
gsettings set org.gnome.settings-daemon.plugins.media-keys www-static [] #default ['XF86WWW']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute-quiet-static [] #default ['<Alt>XF86AudioMute']
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier-zoom-out [] #default ['<Alt><Super>minus']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down-quiet-static [] #default ['<Alt>XF86AudioLowerVolume', '<Alt><Ctrl>XF86AudioLowerVolume']
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot [] #default ['<Alt>Print']
gsettings set org.gnome.settings-daemon.plugins.media-keys power-static [] #default ['XF86PowerOff']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down-static [] #default ['XF86AudioLowerVolume', '<Ctrl>XF86AudioLowerVolume']
gsettings set org.gnome.settings-daemon.plugins.media-keys playback-random-static [] #default ['XF86AudioRandomPlay']
gsettings set org.gnome.settings-daemon.plugins.media-keys screen-brightness-cycle-static [] #default ['XF86MonBrightnessCycle']
gsettings set org.gnome.settings-daemon.plugins.media-keys media-static [] #default ['XF86AudioMedia']
gsettings set org.gnome.settings-daemon.plugins.media-keys hibernate-static [] #default ['XF86Suspend', 'XF86Hibernate']
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip [] #default ['<Ctrl>Print']
gsettings set org.gnome.settings-daemon.plugins.media-keys email-static [] #default ['XF86Mail']
gsettings set org.gnome.settings-daemon.plugins.media-keys logout [] #default ['<Control><Alt>Delete']
gsettings set org.gnome.settings-daemon.plugins.media-keys help [] #default ['', '<Super>F1']
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot [] #default ['<Shift>Print']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up-quiet-static [] #default ['<Alt>XF86AudioRaiseVolume', '<Alt><Ctrl>XF86AudioRaiseVolume']
gsettings set org.gnome.settings-daemon.plugins.media-keys screencast [] #default ['<Ctrl><Shift><Alt>R']
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver-static [] #default ['XF86ScreenSaver']
gsettings set org.gnome.settings-daemon.plugins.media-keys screen-brightness-down-static [] #default ['XF86MonBrightnessDown']
gsettings set org.gnome.settings-daemon.plugins.media-keys touchpad-off-static [] #default ['XF86TouchpadOff']
gsettings set org.gnome.settings-daemon.plugins.media-keys playback-rewind-static [] #default ['XF86AudioRewind']
gsettings set org.gnome.settings-daemon.plugins.media-keys screenreader [] #default ['<Alt><Super>s']
gsettings set org.gnome.settings-daemon.plugins.media-keys playback-repeat-static [] #default ['XF86AudioRepeat']
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier [] #default ['<Alt><Super>8']
gsettings set org.gnome.settings-daemon.plugins.media-keys suspend-static [] #default ['XF86Sleep']
gsettings set org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-toggle-static [] #default ['XF86KbdLightOnOff']
gsettings set org.gnome.settings-daemon.plugins.media-keys mic-mute-static [] #default ['XF86AudioMicMute']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up-precise-static [] #default ['<Shift>XF86AudioRaiseVolume', '<Ctrl><Shift>XF86AudioRaiseVolume']
gsettings set org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-up-static [] #default ['XF86KbdBrightnessUp']
gsettings set org.gnome.settings-daemon.plugins.media-keys playback-forward-static [] #default ['XF86AudioForward']
gsettings set org.gnome.settings-daemon.plugins.media-keys rfkill-bluetooth-static [] #default ['XF86Bluetooth']
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver [] #default ['<Super>l']
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center-static [] #default ['XF86Tools']
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot [] #default ['Print']
gsettings set org.gnome.settings-daemon.plugins.media-keys touchpad-on-static [] #default ['XF86TouchpadOn']
gsettings set org.gnome.settings-daemon.plugins.media-keys next-static [] #default ['XF86AudioNext', '<Ctrl>XF86AudioNext']
gsettings set org.gnome.settings-daemon.plugins.media-keys previous-static [] #default ['XF86AudioPrev', '<Ctrl>XF86AudioPrev']
gsettings set org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-down-static [] #default ['XF86KbdBrightnessDown']
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down-precise-static [] #default ['<Shift>XF86AudioLowerVolume', '<Ctrl><Shift>XF86AudioLowerVolume']
