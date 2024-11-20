import os
import subprocess
from Xlib import display as xdisplay

from libqtile import bar, hook, layout, widget
from libqtile.log_utils import logger
from libqtile.widget import backlight
from libqtile.config import (
    Click, Drag, DropDown, Group, Key, Match, Screen, ScratchPad
)
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal, send_notification


mod = "mod4"
terminal = guess_terminal()

gruvbox = {
    "bg": "#282828",
    "red": "#cc241d",
    "green": "#98971a",
    "yellow": "#d79921",
    "blue": "#458588",
    "purple": "#b16286",
    "aqua": "#689d6a",
    "gray": "#a89984",
    "dark_gray": "#928374",
    "bright_red": "#fb4934",
    "bright_green": "#b8bb26",
    "bright_yellow": "#fabd2f",
    "bright_blue": "#83a598",
    "bright_purple": "#d3869b",
    "bright_aqua": "#8ec07c",
    "fg": "#ebdbb2",
}

colors = gruvbox


@lazy.function
def lock(qtile):
    subprocess.Popen("i3lock -i /home/ghislain/Pictures/wallpapers/seamless-2033661_640.png -e -t", shell=True)


@lazy.function
def menu(qtile):
    subprocess.Popen("rofi -show run -theme gruvbox-dark", shell=True)


keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "z", lazy.window.toggle_fullscreen()),
    Key([mod], "x", lock),
    Key([mod], "space", menu),
    Key([mod, "control"], "p", lazy.spawn("scrot -s -f"), desc="Screenshot selected area"),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.widget["backlight"].change_backlight(backlight.ChangeDirection.UP),
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.widget["backlight"].change_backlight(backlight.ChangeDirection.DOWN),
    ),
]

groups = [Group(i) for i in ["1", "2", "3", "4", "5", "6", "7", "8", "9"]]

for i, group in enumerate(groups):
    keys.extend(
        [
            Key(
                [mod],
                str(i + 1),
                lazy.group[group.name].toscreen(),
                desc="Switch to group {}".format(group.name),
            ),
            Key(
                [mod, "shift"],
                str(i + 1),
                lazy.window.togroup(group.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(group.name),
            ),
        ]
    )

groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown("term", "alacritty", x=0.25, y=0.25, width=0.5, height=0.5, opacity=1),
            DropDown("keepass", "keepassxc", x=0.25, y=0.25, width=0.5, height=0.5, opacity=1),
            DropDown("cmus", "alacritty -e cmus", x=0.25, y=0.25, width=0.5, height=0.5, opacity=1),
        ],
    ),
)

keys.extend(
    [
        Key([mod, "shift"], "Return", lazy.group["scratchpad"].dropdown_toggle("term")),
        Key([mod, "shift"], "p", lazy.group["scratchpad"].dropdown_toggle("keepass")),
        Key([mod, "shift"], "m", lazy.group["scratchpad"].dropdown_toggle("cmus")),
    ]
)

layouts = [
    layout.Columns(
        border_focus=colors["bright_green"],
        border_normal=colors["gray"],
        border_focus_stack=[colors["green"], colors["bright_green"]],
        border_width=2,
        margin=6,
    ),
    layout.Max(
        border_focus=colors["bright_green"],
        border_normal=colors["gray"],
        border_width=2,
        margin=[6, 6, 6, 6],
    ),
]

widget_defaults = dict(
    font="Hack Nerd Font Mono",
    fontsize=24,
    foreground=colors["fg"],
    padding=3,
)
extension_defaults = widget_defaults.copy()


primary_bar = bar.Bar(
        [
            widget.GroupBox(
                disable_drag=True,
                fontsize=28,
                highlight_method="block",
                other_current_screen_border=colors["bright_blue"],
                other_screen_border=colors["bright_blue"],
                this_current_screen_border=colors["green"],
                this_screen_border=colors["blue"],
                inactive=colors["aqua"],
                rounded=True,
                urgent_border=colors["red"],
            ),
            widget.Chord(
                chords_colors={
                    "launch": ("#ff0000", "#ffffff"),
                },
                name_transform=lambda name: name.upper(),
            ),
            widget.Spacer(),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.ThermalSensor(tag_sensor="Package id 0", format="{temp:2.0f}ºC", update_interval=3),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.CPU(format="{freq_current:.1f}GHz {load_percent:2.0f}%", update_interval=3),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.Memory(measure_mem="G", update_interval=3),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.Backlight(backlight_name="intel_backlight"),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.Battery(low_foreground=colors["bright_red"]),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.Systray(),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.Clock(format="%Y-%m-%d %a %H:%M"),
            widget.TextBox(text=" ", fontsize=12),
        ],
        50,
        background=colors["bg"] + "E0",
        margin=[4, 6, 0, 6],
    )


def secondary_bar():
    return bar.Bar(
        [
            widget.GroupBox(
                disable_drag=True,
                fontsize=28,
                highlight_method="block",
                other_current_screen_border=colors["bright_blue"],
                other_screen_border=colors["bright_blue"],
                this_current_screen_border=colors["green"],
                this_screen_border=colors["blue"],
                inactive=colors["aqua"],
                rounded=True,
                urgent_border=colors["red"],
            ),
            widget.Chord(
                chords_colors={
                    "launch": ("#ff0000", "#ffffff"),
                },
                name_transform=lambda name: name.upper(),
            ),
            widget.Spacer(),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.ThermalSensor(tag_sensor="Package id 0", format="{temp:2.0f}ºC", update_interval=3),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.CPU(format="{freq_current:.1f}GHz {load_percent:2.0f}%", update_interval=3),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.Memory(measure_mem="G", update_interval=3),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.Backlight(backlight_name="intel_backlight"),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.Battery(low_foreground=colors["bright_red"]),
            widget.TextBox(text=" ⦚ ", foreground=colors["bright_green"], fontsize=30),
            widget.Clock(format="%Y-%m-%d %a %H:%M"),
            widget.TextBox(text=" ", fontsize=12),
        ],
        50,
        background=colors["bg"] + "E0",
        margin=[4, 6, 0, 6],
    )


def setup_screens():
    screens = []
    root = xdisplay.Display().screen().root
    logger.warn(dir(root))
    for m in root.xrandr_get_monitors().monitors:
        if m.primary:
            logger.warn("Setting primary screen")
            screens.append(Screen(top=primary_bar))
        else:
            logger.warn("Setting secondary screen")
            screens.append(Screen(top=secondary_bar()))
    return screens


screens = setup_screens()

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

wmname = "LG3D"


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.Popen([home])


@hook.subscribe.client_new
def hook_client_new(c):
    if "mattermost" in c.info()["wm_class"]:
        c.togroup("9")
    elif "thunderbird" in c.info()["wm_class"]:
        c.togroup("8")
    elif "qutebrowser" in c.info()["wm_class"]:
        c.togroup("2")


@hook.subscribe.screens_reconfigured
def hook_screen_reconfigured():
    screens = setup_screens()
    send_notification("qtile", "Screens have been reconfigured")
