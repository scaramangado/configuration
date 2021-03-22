return {
	cmd = {
		"urxvtd",
		"numlockx on",
		"jetbrains-toolbox --minimize",
		"blueman-tray",
		"/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1"
	},
	shell = {
		"killall picom ; sleep 0.1 ; picom",
		"killall pasystray ; pasystray &",
		"pgrep keepassxc || keepassxc",
		"pgrep Discord || (sleep 3 && discord --start-minimized)",
		"pgrep nextcloud || nextcloud",
		-- "while [ true ] ; do echo -n | xsel -n -i ; sleep 0.5 ; done",
		"nitrogen --random --set-scaled ~/.config/awesome/wallpapers || exit 0",
		"~/.config/polybar/launch.sh",
		"pgrep thunderbird || thunderbird",
		"/usr/libexec/deja-dup/deja-dup-monitor",
		"/usr/lib/deja-dup/deja-dup-monitor",
	}
}

