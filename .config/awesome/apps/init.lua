local _, user_apps = pcall(require, "apps.default-apps")

local apps_config = {
	default = {
		browser = "brave-browser",
		social = "discord",
		terminal = "urxvtc",
		files = "nemo",
		mail = "thunderbird",
		music = "flatpak run com.spotify.Client",
		lock = "i3lock -i .config/awesome/wallpapers/outset_day.png"
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
end

return apps_config

