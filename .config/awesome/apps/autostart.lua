return {
	cmd = {
		"urxvtd",
		"numlockx on",
		"jetbrains-toolbox --minimize",
		"blueman-tray"
	},
	shell = {
		"killall compton ; compton",
		"killall pasystray ; pasystray &",
		"pgrep Discord || flatpak run com.discordapp.Discord --start-minimized",
		"while [ true ] ; do echo -n | xsel -n -i ; sleep 0.5 ; done",
		"nitrogen --random --set-scaled ~/.config/awesome/wallpapers",
		"~/.config/polybar/launch.sh",
		"pgrep dropbox && killall dropbox ; flatpak run com.dropbox.Client",
		"pgrep thunderbird || thunderbird"
	}
}

