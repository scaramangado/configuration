return {
	cmd = {
		"urxvtd",
		"numlockx on",
		"jetbrains-toolbox --minimize",
		"/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1",
		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
		"nm-applet",
	},
	shell = {
		"flatpak run com.github.wwmm.easyeffects --gapplication-service",
		"killall picom ; sleep 0.2 ; picom",
		"killall pasystray ; sleep 0.5 ; pasystray &",
		"sleep 0.5 ; blueman-applet",
		"pgrep keepassxc || keepassxc",
		"GDK_SCALE=1 GDK_DPI_SCALE=1 pgrep Discord || (sleep 3 && discord)",
		"pgrep nextcloud || nextcloud",
		-- "while [ true ] ; do echo -n | xsel -n -i ; sleep 0.5 ; done",
		-- "nitrogen --set-scaled ~/.config/awesome/wallpapers/pyramids.png || exit 0",
		"nitrogen --restore || exit 0",
		"~/.config/polybar/launch.sh",
		"pgrep thunderbird || thunderbird",
		"/usr/libexec/deja-dup/deja-dup-monitor",
		"/usr/lib/deja-dup/deja-dup-monitor",
	}
}

