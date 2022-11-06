#!/bin/sh

( cd ~/.config/polybar ; ./launch_qtile.sh ) &
killall picom ; sleep 0.2 ; picom &
killall pasystray ; sleep 0.5 ; pasystray &
sleep 0.5 ; blueman-applet &
pgrep keepassxc || keepassxc &
GDK_SCALE=1 GDK_DPI_SCALE=1 pgrep Discord || (sleep 3 && discord --start-minimized) &
pgrep nextcloud || nextcloud &
nitrogen --restore || exit 0 &
pgrep thunderbird || thunderbird &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
numlockx on &
jetbrains-toolbox --minimize &
