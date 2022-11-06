import os
import subprocess

from libqtile import layout, hook, bar
from libqtile.config import Key, Group, Screen, Match, Rule
from libqtile.lazy import lazy

meta = "mod4"
alt = "mod1"
ctrl = "control"
shift = "shift"

terminal = "/usr/bin/alacritty"
browser = "/usr/bin/brave"
launcher = "/usr/bin/rofi -config ~/.config/rofi-themes/launcher.rasi -modi drun -show drun"

keys = [
    Key([meta, ], "space", lazy.spawn(launcher), desc="Open launcher"),
    Key([meta, ], "Return", lazy.spawn(terminal), desc="Launch Terminal"),
    Key([meta, ], "b", lazy.spawn(browser), desc="Launch Browser"),

    Key([meta, ], "Left", lazy.screen.prev_group(), desc="Go to then group on the left"),
    Key([meta, ], "Right", lazy.screen.next_group(), desc="Go to then group on the right"),
    Key([meta, ], "h", lazy.to_screen(0), desc="Go to left screen"),
    Key([meta, ], "l", lazy.to_screen(1), desc="Go to right screen"),

    Key([meta, shift, ], "h", lazy.layout.shuffle_left(), desc="Move window left"),
    Key([meta, shift, ], "l", lazy.layout.shuffle_right(), desc="Move window right"),
    Key([meta, shift, ], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([meta, shift, ], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([meta, ctrl, ], "l", lazy.layout.grow_main(), desc="Grow main window"),
    Key([meta, ctrl, ], "h", lazy.layout.shrink_main(), desc="Shrink main window"),
    Key([meta, ctrl, ], "plus", lazy.layout.grow(), desc="Grow window"),
    Key([meta, ctrl, ], "minus", lazy.layout.shrink(), desc="Shrink window"),
    Key([meta, ], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key([meta, ], "q", lazy.window.kill(), desc="Close focused window"),
    Key([meta, ], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),

    Key([meta, ctrl], "F5", lazy.restart(), desc="Restart Qtile"),
    Key([meta, ], "Escape", lazy.shutdown(), desc="Shutdown Qtile"),
]

groups = [
    Group("1"),
    Group("2", matches=[Match(wm_class="discord")]),
    Group("3"),
    Group("4", layout="floating"),
    Group("5", matches=[Match(wm_class="Thunderbird")]),
    Group("6", matches=[Match(wm_class="Spotify")]),
    Group("7"),
    Group("8"),
    Group("9"),
]

for i in groups:
    keys.extend([
        Key([meta, ], i.name, lazy.group[i.name].toscreen(), desc="Switch to group {}".format(i.name)),
        Key([meta, "shift", ], i.name, lazy.window.togroup(i.name), desc="Move window to group {}".format(i.name)),
    ])

layout_settings = {
    "border_focus": "#ffffff",
    "border_width": 2,
    "margin": 10,
    "new_client_position": "bottom",
    "single_border_width": 1,
    "single_margin": 10,
}

layouts = [
    layout.MonadTall(**layout_settings),
    layout.Floating(name="floating", **layout_settings),
]

screens = [
    Screen(top=bar.Gap(size=60)),
    Screen(top=bar.Gap(size=60))
]

follow_mouse_focus = False
bring_front_click = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = False


@hook.subscribe.startup
def autostart():
    autostart_script = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([autostart_script])


@hook.subscribe.client_new
def func(c):
    if c.window.get_wm_class() == ["gnome-calculator", "Gnome-calculator"]:
        c.floating = True
    if (c.window.get_wm_class() == ["jetbrains-idea-ce", "jetbrains-idea-ce"] and
            c.window.get_name() == "win0"):
        c.floating = True
