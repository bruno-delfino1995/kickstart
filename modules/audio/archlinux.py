from pyinfra.operations import pacman, systemd

pacman.packages(
    name="Install audio back-end",
    _sudo=True,
    packages=[
        "pipewire",
        "pipewire-audio",
        "pipewire-alsa",
        "pipewire-pulse",
        "wireplumber",
    ],
)

pacman.packages(name="Install audio GUI", _sudo=True, packages=["pavucontrol"])

pacman.packages(
    name="Install bluetooth back-end", _sudo=True, packages=["bluez", "bluez-utils"]
)

pacman.packages(name="Install bluetooth GUI", _sudo=True, packages=["blueman"])

systemd.service(
    name="Enable bluetooth service",
    _sudo=True,
    service="bluetooth.service",
    enabled=True,
    running=True,
)

pacman.packages(name="Install PlayerCTL", _sudo=True, packages=["playerctl"])
