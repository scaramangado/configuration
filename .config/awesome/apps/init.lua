local _, user_apps = pcall(require, "apps.default-apps")

local apps_config = {
	default = {
		browser = "brave-browser --force-device-scale-factor=2",
		social = "discord",
		terminal = "alacritty",
		files = "nemo",
		mail = "thunderbird",
		music = "flatpak run com.spotify.Client",
		lock = "i3lock -i ~/.config/awesome/wallpapers/pyramids.png && qdbus org.keepassxc.KeePassXC.MainWindow /keepassxc org.keepassxc.MainWindow.lockAllDatabases",
		password = "keepassxc",
		calculator = "flatpak run org.gnome.Calculator",
		screenshot = "maim -s -u | xclip -selection clipboard -t image/png -i" 
	},
	autostart = require("apps.autostart")
}

if user_apps then
	if user_apps.browser then apps_config.default.browser = user_apps.browser end
	if user_apps.social then apps_config.default.social = user_apps.social end
	if user_apps.terminal then apps_config.default.terminal = user_apps.terminal end
	if user_apps.files then apps_config.default.files = user_apps.files end
	if user_apps.mail then apps_config.default.mail = user_apps.mail end
	if user_apps.music then apps_config.default.music = user_apps.music end
	if user_apps.lock then apps_config.default.lock = user_apps.lock end
	if user_apps.password then apps_config.default.password = user_apps.password end
	if user_apps.calculator then apps_config.default.calculator = user_apps.calculator end
	if user_apps.screenshot then apps_config.default.screenshot = user_apps.screenshot end
end

return apps_config

