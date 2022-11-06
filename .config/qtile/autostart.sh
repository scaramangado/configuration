#!/bin/sh

nitrogen --restore || exit 0 &
( cd ~/.config/polybar ; ./launch_qtile.sh ) &
killall picom ; sleep 0.2 ; picom &
killall deadd-notification-center ; deadd-notification-center &
killall pasystray ; sleep 0.5 ; pasystray &
sleep 0.5 ; blueman-applet &
pgrep keepassxc || keepassxc &
GDK_SCALE=1 GDK_DPI_SCALE=1 pgrep Discord || (sleep 3 && discord --start-minimized) &
pgrep nextcloud || nextcloud &
pgrep thunderbird || thunderbird &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
numlockx on &
jetbrains-toolbox --minimize &
nm-applet &
flatpak run com.github.wwmm.easyeffects --gapplication-service &

