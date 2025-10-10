from pyinfra.operations import pacman

pacman.packages(
    name="Install base sway packages",
    _sudo=True,
    packages=[
        "wayland",
        "xorg-xwayland",
        "sway",
        "swayidle",
        "swaylock",
        "swaybg",
        "waybar",
        "wl-clipboard",
    ],
)

pacman.packages(
    name="Install base XDG packages",
    _sudo=True,
    packages=[
        "xdg-user-dirs",
        "xdg-desktop-portal-gtk",
        "xdg-desktop-portal-wlr",
    ]
)

pacman.packages(
    name="Install application autostarter",
    _sudo=True,
    packages=["dex"],
)

pacman.packages(
    name="Install display config daemon",
    _sudo=True,
    packages=["kanshi"],
)

# aur.packages(name="Install display config GUI", packages=["wdisplays"])

# aur.packages(name="Install screenshot helper", packages=["grimshot"])

pacman.packages(
    name="Install screen color thermostat",
    _sudo=True,
    packages=["gammastep"],
)

# aur.packages(name="Install logout widget", packages=["wlogout"])

pacman.packages(
    name="Install network helper",
    _sudo=True,
    packages=["network-manager-applet"],
)

pacman.packages(name="Install audio GUI", _sudo=True, packages=["pavucontrol"])

pacman.packages(name="Install bluetooth GUI", _sudo=True, packages=["blueman"])
