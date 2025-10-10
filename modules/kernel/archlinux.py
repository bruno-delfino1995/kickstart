from pyinfra.operations import pacman, server, systemd

pacman.packages(
    name="Install process visualizer/manager",
    _sudo=True,
    packages=["htop"],
)

# aur.packages(name="Install kernel manager", packages=["kmon"])

pacman.packages(name="Install tracer", _sudo=True, packages=["strace"])

pacman.packages(name="Install mounting helper", _sudo=True, packages=["udisks2"])

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

pacman.packages(
    name="Install bluetooth back-end", _sudo=True, packages=["bluez", "bluez-utils"]
)

systemd.service(
    name="Enable bluetooth service",
    _sudo=True,
    service="bluetooth.service",
    enabled=True,
    running=True,
)

pacman.packages(name="Install PlayerCTL", _sudo=True, packages=["playerctl"])

pacman.packages(
    name="Install NetworkManager",
    _sudo=True,
    packages=["networkmanager"],
)

pacman.packages(
    name="Install wireless daemon",
    _sudo=True,
    packages=["iwd"],
)

systemd.service(
    name="Enable NetworkManager",
    _sudo=True,
    service="NetworkManager",
    enabled=True,
    running=True,
)

pacman.packages(
    name="Install generic tools",
    _sudo=True,
    packages=["bind-tools", "ngrep", "ldns"],
)

systemd.service(
    name="Enable systemd-timesyncd",
    _sudo=True,
    service="systemd-timesyncd",
    enabled=True,
    running=True,
)

server.shell(
    name="Enable NTP",
    _sudo=True,
    commands=["timedatectl set-ntp true"],
)

pacman.packages(
    name="Install OpenVPN",
    _sudo=True,
    packages=["openvpn"],
)

pacman.packages(
    name="Install NetworkManager VPN Helper",
    _sudo=True,
    packages=["networkmanager-openvpn"],
)
