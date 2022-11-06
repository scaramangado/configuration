-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
require("awful.autofocus")

local icons = require("icons")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
require("menus.exit-screen")
local apps = require("apps")

-- Naughty presets
naughty.config.padding = 8
naughty.config.spacing = 8

naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = 'top_right'
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.ontop = true
naughty.config.defaults.font = 'Roboto Regular 10'
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.shape = gears.shape.rounded_rect
naughty.config.defaults.border_width = 0
naughty.config.defaults.hover_timeout = nil

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

local function size(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

local function set_polybar_visible(visible)
	if visible then
		awful.spawn.with_shell("polybar-msg cmd show")
	else 
		awful.spawn.with_shell("polybar-msg cmd hide")
	end
end

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv('HOME') .. "/.config/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
local terminal = apps.default.terminal
local editor = os.getenv("EDITOR") or "editor"
local editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"
local altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
    awful.layout.suit.max,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local launcher_command = "rofi -config ~/.config/rofi-themes/launcher.rasi -modi drun -show drun"

local mylauncher =
wibox.container.margin(awful.widget.launcher({
    image = icons.debian,
    command = launcher_command
}),
    dpi(10), dpi(10), dpi(7), dpi(7))

local systray = wibox.container.margin(wibox.widget.systray(), dpi(10), dpi(10), dpi(6), dpi(6))

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
-- Create a textclock widget
local calender_widget = wibox.widget.textclock("   %a, %B %e  %H:%M   ", 1)
calender_widget.font = "Roboto Bold 10"
calender_widget.align = "center"

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle))

local tasklist_buttons = gears.table.join(awful.button({}, 1, function(c)
    if c == client.focus then
        c.minimized = true
    else
        c:emit_signal("request::activate", "tasklist", { raise = true })
    end
end),
    awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Tags
    local tags = {
        {
            icon = icons.chrome,
            type = 'browse'
        },
        {
            icon = icons.social,
            type = 'social',
        },
        {
            icon = icons.code,
            type = 'code'
        },
				{
						icon = icons.game,
						type = 'gaming',
						layout = awful.layout.suit.floating
				},
				{
						icon = icons.mail,
						type = 'mail'
				},
				{
						icon = icons.music,
						type = 'music'
				}
    }

    for i, tag in pairs(tags) do
        awful.tag.add(i,
            {
                icon = tag.icon,
                icon_only = true,
                screen = s,
                layout = tag.layout or awful.layout.layouts[1],
                selected = i == 1
            })
    end
end)
-- }}}

-- {{{ Focus urgent clients automatically
client.connect_signal("property::urgent", function(c)
    c.minimized = false
    c:jump_to()
end)
--- }}}

local function sort_clients(clients)
    for _, c in pairs(clients) do
        c.geo = c:geometry()
    end

    table.sort(clients,
        function(a, b)
            if a.geo.y ~= b.geo.y then
                return a.geo.y < b.geo.y
            end
            return a.geo.x < b.geo.x
        end)
end


local function unminimize_menu()

    local menu_theme = {
        border_width = 1,
        border_color = "#a9b7c6",
        bg_focus = "#a9b7c6",
        bg_normal = "#2b2b2b",
        fg_focus = "#2b2b2b",
        fg_normal = "#a9b7c6",
        height = 70,
        width = 1000,
        font = "Roboto 12"
    }

    local function unminimize(c)
        c.minimized = false
        client.focus = c
        c:raise()
    end

    local clients = awful.screen.focused().selected_tag:clients()
    local minimized = {}

    for i, c in pairs(clients) do
        if c.minimized then table.insert(minimized, c) end
    end

    if size(minimized) == 1 then
        unminimize(minimized[1])
        return
    end

    local menuitems = {}

    for i, c in pairs(minimized) do
        if c.icon ~= nil then
            table.insert(menuitems, { c.name, function() unminimize(c) end, c.icon })
        else
            table.insert(menuitems, { c.name, function() unminimize(c) end })
        end
    end

    local menu = awful.menu({ items = menuitems, theme = menu_theme })

    local s = awful.screen.focused()
    local m_coords = {
        x = s.geometry.x + s.workarea.width / 2 - 500,
        y = s.geometry.y + s.workarea.height / 2 - 120
    }

    menu:show({ coords = m_coords })
end

-- {{{ Key bindings
globalkeys = gears.table.join(
		awful.key({ modkey, }, "F1", hotkeys_popup.show_help,
				{ description = "show help", group = "awesome" }),
    awful.key({ modkey }, "Escape", function() _G.exit_screen_show() end,
        { description = "Open the Quit Menu", group = "awesome" }),
		awful.key({ modkey }, "l", function() awful.spawn(apps.default.lock) end,
				{ description = "Lock the Screen", group = "awesome" }),
    awful.key({ modkey, }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
    awful.key({ modkey, }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }),

    awful.key({ modkey, }, "j", function() awful.client.focus.byidx(1) end,
        { description = "focus next by index", group = "client" }),
    awful.key({ modkey, }, "k", function() awful.client.focus.byidx(-1) end,
        { description = "focus previous by index", group = "client" }),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),
    awful.key({ modkey, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back", group = "client" }),
    awful.key({ modkey, "Control" }, "d",
        function()
            local t = awful.screen.focused().selected_tag
            t.master_width_factor = 0.565
            local clients = t:clients()
            if size(clients) > 1 then
                sort_clients(clients)
                awful.client.setwfact(0.75, clients[3])
            end
        end,
        { description = "set layout for development", group = "layout" }),
    awful.key({ modkey, "Control" }, "r",
        function()
            local t = awful.screen.focused().selected_tag
            t.master_width_factor = 0.5
            local clients = t:clients()
            if size(clients) > 1 then
                sort_clients(clients)
                awful.client.setwfact(0.5, clients[3])
            end
        end,
        { description = "reset layout", group = "layout" }),

    -- Standard program
    awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, }, "b", function() awful.spawn(apps.default.browser) end,
        { description = "open browser", group = "launcher" }),
    awful.key({ modkey, }, "d", function() awful.spawn(apps.default.social) end,
        { description = "open chat", group = "launcher" }),
		awful.key({ }, "XF86Tools", function() awful.spawn(apps.default.music) end,
        { description = "open m", group = "launcher" }),
    awful.key({ modkey, }, "e", function() awful.spawn(apps.default.files) end,
        { description = "open file manager", group = "launcher" }),
    awful.key({  }, "XF86Mail", function() awful.spawn(apps.default.mail) end,
        { description = "open mail client", group = "launcher" }),
    awful.key({ modkey, "Control" }, "F5", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Control" }, "w", function() beautiful.wallpaper(nil) end,
	{ description = "random wallpaper", gourp = "awesome" }),
    awful.key({ modkey, "Control" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),

    awful.key({ modkey, altkey }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey, altkey }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),
    awful.key({ modkey, altkey }, "j", function() awful.client.incwfact(-0.05, client.focus) end,
        { description = "decrease client height factor", group = "layout" }),
    awful.key({ modkey, altkey }, "k", function() awful.client.incwfact(0.05, client.focus) end,
        { description = "increase client height factor", group = "layout" }),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "m", unminimize_menu,
        { description = "unminimize...", group = "client" }),

    -- Prompt
    awful.key({ modkey }, "space", function() awful.spawn(launcher_command) end,
        { description = "Launch application", group = "launcher" }),

		-- Media keys
		awful.key({ }, "XF86AudioPlay", function() awful.spawn("playerctl play-pause") end,
				{ description = "Play/Pause", group = "media" }),
		awful.key({ }, "XF86AudioNext", function() awful.spawn("playerctl next") end,
				{ description = "Next", group = "media" }),
		awful.key({ }, "XF86AudioPrev", function() awful.spawn("playerctl previous") end,
				{ description = "Previous", group = "media" })
				)

clientkeys = gears.table.join(
    awful.key({ modkey, }, "f", function(c)
            local clients = awful.screen.focused().selected_tag:clients()
	    if c.fullscreen then
				c.fullscreen = false
				set_polybar_visible(true)
		for _, client in pairs(clients) do
		    client.hidden = false
		end
            else
	        c.fullscreen = true
					set_polybar_visible(false)
		for _, client in pairs(clients) do
		    if client ~= c then
		        client.hidden = true
		    end
		end
            end
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "q", function(c) c:kill() end,
        { description = "close", group = "client" }),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }),
    awful.key({ modkey, "Shift" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }),
    awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
        { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey, }, "m", function(c) c.minimized = true end,
        { description = "minimize client", group = "client" }),
		awful.key({ modkey, }, "F11", function(c)
				c.maximized = not c.maximized
        c:raise()
			end,
        { description = "toggle maximized", group = "client" }))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 6 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. i, group = "tag" }))
end

clientbuttons = gears.table.join(awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        }
    },

		{ rule = { class = "Polybar" },
			properties = { border_width = 0,
										 focusable = false,
									   x = 0, y = 0 }},	 

    { rule = { name = "Discord" },
      properties = { tag = awful.screen.focused().tags[2],
                     focus = false }},

    { rule = { class = "Spotify" },
      properties = { tag = awful.screen.focused().tags[6],
                     focus = true }},

    { rule = { class = "jetbrains-idea-ce", name = "win0" },
      properties = { floating = true }
    },

		{ rule = { name = "Picture in picture" },
		  properties = { floating = true }
	  },

		{ rule = { class = "thunderbird" },
			properties = { tag = awful.screen.focused().tags[5],
                     focus = false }
		},
}

-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup
			and c.class ~= "jetbrains-idea-ce"
			and c.class ~= "jetbrains-pycharm-ce"
			and c.class ~= "VSCodium" then
			awful.client.setslave(c)
		end

    c.size_hints_honor = false

    if awesome.startup
            and not c.size_hints.user_position
            and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

local function update_menubar_visibility(screen)
    local clients = screen.selected_tag:clients()
    local fullscreen = false
    for _, c in pairs(clients) do
        if c.fullscreen then fullscreen = true end
    end
    set_polybar_visible(not fullscreen)
end

screen.connect_signal("tag::history::update", update_menubar_visibility)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

do
    for _, cmd in pairs(apps.autostart.cmd) do
        awful.util.spawn(cmd)
    end


    for _, shell_cmd in pairs(apps.autostart.shell) do	
        awful.spawn.with_shell(shell_cmd)
    end
end
-- }}}

-- Hide polybar tray when client uses built-in fullscreen
client.connect_signal("request::geometry", function(c, context, ...)
    if context == "fullscreen" then
        update_menubar_visibility(c.screen)
    end
end)

