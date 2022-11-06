local awful = require("awful")
local dpi = require("beautiful.xresources").apply_dpi
local themes_path = os.getenv('HOME') .. "/.config/awesome/themes/"

local theme = {}

theme.font          = "Roboto 12"

--theme.menu_bg_normal = "#1b1b1b"
theme.menu_bg_normal = "#232323"

theme.bg_normal     = "#0e476c"
theme.bg_focus      = "#474747"
theme.bg_urgent     = "#c03221"
theme.bg_minimize   = "#bbbbbb"

theme.bg_systray    = theme.menu_bg_normal
theme.systray_icon_spacing = 5

--local menu_fg = "#ebf2fa"
local menu_fg = "#e5e5e5"

theme.fg_normal     = menu_fg
theme.fg_focus      = menu_fg
theme.fg_urgent     = menu_fg
theme.fg_minimize   = menu_fg

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(1)
theme.border_normal = "#00000000"
theme.border_focus  = "#a9b7c6"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

local taglist_bg_normal = menu_bg_normal

local overline = '#1b98e0'
local bg_active = '#051E2C'

theme.taglist_bg_empty = taglist_bg_normal
theme.taglist_bg_occupied = taglist_bg_normal
theme.taglist_bg_focus = {
    type = "linear",
    from = { 30, 0 },
    to = { 30, 30 },
    stops = { { 0, overline }, { 0.07 * dpi(1), overline }, { 0.08 * dpi(1), bg_active }, { 1, bg_active } }
}
theme.taglist_fg_focus = taglist_bg_normal

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(30)
theme.menu_width  = dpi(200)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load

theme.wallpaper = function(s) awful.spawn.with_shell("nitrogen --random --set-scaled ~/.config/awesome/wallpapers") end

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus-Dark"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
