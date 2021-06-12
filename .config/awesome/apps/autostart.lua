return {
	cmd = {
		"urxvtd",
		"numlockx on",
		"jetbrains-toolbox --minimize",
		"blueman-tray",
		"/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1",
		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
	},
	shell = {
		"killall picom ; sleep 0.2 ; picom",
		"killall pasystray ; pasystray &",
		"pgrep keepassxc || keepassxc",
		"GDK_SCALE=1 GDK_DPI_SCALE=1 pgrep Discord || (sleep 3 && discord --start-minimized)",
		"pgrep nextcloud || nextcloud",
		-- "while [ true ] ; do echo -n | xsel -n -i ; sleep 0.5 ; done",
		"nitrogen --set-scaled ~/.config/awesome/wallpapers/pyramids.png || exit 0",
		"~/.config/polybar/launch.sh",
		"pgrep thunderbird || thunderbird",
		"/usr/libexec/deja-dup/deja-dup-monitor",
		"/usr/lib/deja-dup/deja-dup-monitor",
	}
}

