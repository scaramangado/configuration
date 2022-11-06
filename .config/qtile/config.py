import asyncio
import os
import subprocess

from libqtile import layout, hook, bar, widget, qtile
from libqtile.backend.x11.window import Window
from libqtile.config import Key, Group, Screen, Match
from libqtile.lazy import lazy
from xcffib.xproto import EventMask
from libqtile.log_utils import logger

meta = "mod4"
alt = "mod1"
ctrl = "control"
shift = "shift"

terminal = "/usr/bin/alacritty"
browser = "/usr/bin/brave"
launcher = "/usr/bin/rofi -config ~/.config/rofi-themes/launcher.rasi -modi drun -show drun"
password_manager = "keepassxc"

layout_settings = {
    "border_focus": "#ffffff",
    "border_width": 2,
    "margin": 10,
    "new_client_position": "bottom",
    "single_border_width": 1,
    "single_margin": 10,
    "change_ratio": 0.01,
    "change_size": 10,
}

layouts = [
    layout.MonadTall(**layout_settings),
    layout.Max(),
    layout.Floating(**layout_settings),
]

floating_layout = layout.Floating(**layout_settings)


def toggle_dev(q):
    group = q.current_group
    if type(group.layout) is not layout.MonadTall or len(group.layout.clients) != 3:
        return
    group.layout.ratio = 0.565
    group.layout.relative_sizes = [0.75, 0.25]
    group.layout_all()

    # noinspection PyUnresolvedReferences
    # if group.layout.info()["name"] == "dev":
    #     group.layout = "monadtall"
    # else:
    #     group.layout = "dev"


def toggle_fullscreen(q):
    group = q.current_group
    if type(group.layout) is layout.Max:
        group.layout = "monadtall"
    else:
        group.layout = "max"
    refresh_bar(q)


def refresh_bar(q):
    for screen in q.screens:
        screen_name = "DisplayPort-" + str(screen.index)
        pid = read_first_line("/tmp/polybar_" + screen_name + ".pid")
        if type(screen.group.layout) is layout.Max:
            q.cmd_spawn(("polybar-msg -p " + pid + " cmd hide").split())
            type(screen.top) is bar.Bar and screen.top.show(False)
        else:
            q.cmd_spawn(("polybar-msg -p " + pid + " cmd show").split())
            type(screen.top) is bar.Bar and screen.top.show(True)


def read_first_line(filename):
    with open(filename) as file:
        return file.read()


keys = [
    Key([meta, ], "space", lazy.spawn(launcher), desc="Open launcher"),
    Key([meta, ], "Return", lazy.spawn(terminal), desc="Launch Terminal"),
    Key([meta, ], "b", lazy.spawn(browser), desc="Launch Browser"),
    Key([meta, shift, ], "b", lazy.spawn(browser + " --incognito"), desc="Launch Private Browser"),
    Key(["mod5", ], "k", lazy.spawn(password_manager), desc="Launch Password Manager"),

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
    Key([meta, ctrl, ], "d", lazy.function(toggle_dev), desc="Toggle dev layout"),
    Key([meta, ctrl, ], "r", lazy.layout.reset(), desc="Reset all window sizes"),

    Key([meta, ], "q", lazy.window.kill(), desc="Close focused window"),
    Key([meta, ], "f", lazy.function(toggle_fullscreen), desc="Toggle fullscreen"),
    Key([meta, ctrl, ], "space", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([meta, ], "F11", lazy.window.toggle_maximize(), desc="Toggle maximize"),

    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Play/Pause"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Next"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="Previous"),
    Key([], "XF86AudioMute", lazy.spawn("pactl -- set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggle Mute"),

    Key([meta, ctrl], "F5", lazy.restart(), desc="Restart Qtile"),
    Key([meta, ], "Escape", lazy.shutdown(), desc="Shutdown Qtile"),
]

groups = [
    Group("1"),
    Group("2", matches=[Match(wm_class="discord")]),
    Group("3"),
    Group("4", layout="floating"),
    Group("5", matches=[Match(wm_class="Thunderbird")]),
    Group("6"),
    Group("7"),
    Group("8"),
    Group("9"),
]

for i in groups:
    keys.extend([
        Key([meta, ], i.name, lazy.group[i.name].toscreen(), desc="Switch to group {}".format(i.name)),
        Key([meta, "shift", ], i.name, lazy.window.togroup(i.name), desc="Move window to group {}".format(i.name)),
    ])


def test():
    logger.warning("click")


screens = [
    Screen(top=bar.Bar(
        [
            widget.TextBox(
                text="",
                font="Hack NF",
                foreground="#e5e5e5",
                background="#232323",
                fontsize=60,
                padding=10,
                # mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("kill -s USR1 $(pidof deadd-notification-center)")},
                mouse_callbacks={'Button1': test},
            ),
        ],
        60,
        margin=[0, 0, 0, 3780],
        background="#232323"
    )),
    Screen(top=bar.Bar([], 60))
]

follow_mouse_focus = False
bring_front_click = True
cursor_warp = False
auto_fullscreen = False
focus_on_window_activation = "urgent"
reconfigure_screens = True
auto_minimize = False


@hook.subscribe.startup
def autostart():
    autostart_script = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([autostart_script])


@hook.subscribe.client_new
def window_rules(c):
    # Floating calculator
    if c.window.get_wm_class() == ["gnome-calculator", "Gnome-calculator"]:
        c.floating = True
    # Floating IntelliJ splash
    if (c.window.get_wm_class() == ["jetbrains-idea-ce", "jetbrains-idea-ce"] and
            c.window.get_name() == "win0"):
        c.floating = True
    # Floating PyCharm splash
    if (c.window.get_wm_class() == ["jetbrains-pycharm-ce", "jetbrains-pycharm-ce"] and
            c.window.get_name() == "win0"):
        c.floating = True


@hook.subscribe.client_new
async def spotify(c):
    await asyncio.sleep(0.1)
    if c.window.get_wm_class() == ["spotify", "Spotify"]:
        c.togroup("6")


@hook.subscribe.focus_change
def refresh():
    refresh_bar(qtile)


def screen_change(event, q):
    x = -1
    y = -1
    if type(event) is Window:
        x = event.x
        y = event.y
    elif hasattr(event, "root_x") and hasattr(event, "root_y"):
        x = event.root_x
        y = event.root_y
    if x == -1 or y == -1:
        return
    screen = q.find_screen(x, y)
    if screen:
        index_under_mouse = screen.index
        if index_under_mouse != q.current_screen.index:
            q.focus_screen(index_under_mouse, warp=False)
            if type(event) is Window:
                event.cmd_focus(warp=False)
    q.process_button_motion(x, y)


def mouse_move(q):
    assert q is not None
    # noinspection PyProtectedMember
    q.core._root.set_attribute(eventmask=(EventMask.StructureNotify
                                          | EventMask.SubstructureNotify
                                          | EventMask.SubstructureRedirect
                                          | EventMask.EnterWindow
                                          | EventMask.LeaveWindow
                                          | EventMask.ButtonPress
                                          | EventMask.PointerMotion))
    setattr(q.core, "handle_MotionNotify", lambda e: screen_change(e, q))


@hook.subscribe.client_mouse_enter
def hover(window):
    screen_change(window, qtile)


@hook.subscribe.startup
def enable_auto_screen_focus():
    mouse_move(qtile)
