return {
	cmd = {
		"urxvtd",
		"numlockx on",
		"jetbrains-toolbox --minimize",
		"/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1",
		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
		"nm-applet",
		"mullvad-vpn",
	},
	shell = {
		"killall picom ; sleep 0.2 ; picom",
		"~/.config/polybar/launch.sh",
		"killall pasystray ; sleep 0.5 ; pasystray -n &",
		"sleep 0.5 ; blueman-applet",
		"pgrep keepassxc || keepassxc",
		-- "nitrogen --set-scaled ~/.config/awesome/wallpapers/pyramids.png || exit 0",
		"nitrogen --restore || exit 0",
		"GDK_SCALE=1 GDK_DPI_SCALE=1 pgrep discord || (sleep 3 && flatpak run com.discordapp.Discord)",
		"pgrep thunderbird || thunderbird",
		"pgrep nextcloud || nextcloud",
		"pgrep joplin || flatpak run net.cozic.joplin_desktop",
		"flatpak run com.github.wwmm.easyeffects --gapplication-service",
	}
}

