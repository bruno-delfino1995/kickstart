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
        "xdg-desktop-portal-gtk",
        "xdg-desktop-portal-wlr",
    ],
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
