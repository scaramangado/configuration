return {
	cmd = {
		"urxvtd",
		"flatpak run com.dropbox.Client",
		"compton",
		"numlockx on",
		"jetbrains-toolbox --minimize",
		"blueman-tray",
		"thunderbird"
	},
	shell = {
		"killall pasystray ; pasystray &",
		"pgrep Discord || flatpak run com.discordapp.Discord --start-minimized",
		"while [ true ] ; do echo -n | xsel -n -i ; sleep 0.5 ; done",
		"nitrogen --random --set-scaled ~/.config/awesome/wallpapers"
	}
}

